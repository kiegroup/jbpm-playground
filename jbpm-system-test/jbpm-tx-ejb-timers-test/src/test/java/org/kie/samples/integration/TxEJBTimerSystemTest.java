/*
 * Copyright 2021 Red Hat, Inc. and/or its affiliates.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.kie.samples.integration;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.kie.samples.integration.testcontainers.KieServerContainer;
import org.kie.server.api.marshalling.MarshallingFormat;
import org.kie.server.api.model.KieContainerResource;
import org.kie.server.api.model.ReleaseId;
import org.kie.server.client.KieServicesClient;
import org.kie.server.client.KieServicesConfiguration;
import org.kie.server.client.KieServicesFactory;
import org.kie.server.client.ProcessServicesClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.DockerClientFactory;
import org.testcontainers.containers.BindMode;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.github.dockerjava.api.DockerClient;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Testcontainers(disabledWithoutDocker=true)
class TxEJBTimerSystemTest {
    
    public static final String SELECT_COUNT_FROM_JBOSS_EJB_TIMER = "select count(*) from jboss_ejb_timer";
    public static final String ARTIFACT_ID = "tx-ejb-sample";
    public static final String GROUP_ID = "org.kie.server.testing";
    public static final String VERSION = "1.0.0";
    public static final String ALIAS = "-alias";
    
    public static final String DEFAULT_USER = "kieserver";
    public static final String DEFAULT_PASSWORD = "kieserver1!";

    public static String containerId = GROUP_ID+":"+ARTIFACT_ID+":"+VERSION;

    private static Logger logger = LoggerFactory.getLogger(TxEJBTimerSystemTest.class);
    
    protected static Map<String, String> args = new HashMap<>();

    static {
        args.put("IMAGE_NAME", System.getProperty("org.kie.samples.image"));
        args.put("START_SCRIPT", System.getProperty("org.kie.samples.script"));
        args.put("SERVER", System.getProperty("org.kie.samples.server"));
        args.put("cache", System.getProperty("org.jbpm.ejb.timer.local.cache"));
        args.put("timer-tx", System.getProperty("org.jbpm.ejb.timer.tx"));
    }
    
    public static Network network = Network.newNetwork();
    
    @Container
    public static PostgreSQLContainer<?> postgreSQLContainer = new PostgreSQLContainer<>(System.getProperty("org.kie.samples.image.postgresql","postgres:latest"))
                                        .withDatabaseName("rhpamdatabase")
                                        .withUsername("rhpamuser")
                                        .withPassword("rhpampassword")
                                        .withFileSystemBind("target/postgresql", "/docker-entrypoint-initdb.d",
                                                            BindMode.READ_ONLY)
                                        .withCommand("-c max_prepared_transactions=10")
                                        .withNetwork(network)
                                        .withNetworkAliases("postgresql11");
    
    
    @Container
    public static KieServerContainer kieServer = new KieServerContainer(network, args);
    
    private static KieServicesClient ksClient;
    
    private static ProcessServicesClient processClient;
    
    private static HikariDataSource ds;
    
    @BeforeAll
    public static void setup() {
        logger.info("KIE SERVER 1 started at port "+kieServer.getKiePort());
        logger.info("postgresql started at "+postgreSQLContainer.getJdbcUrl());
        
        ksClient = authenticate(kieServer.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);
        
        processClient = ksClient.getServicesClient(ProcessServicesClient.class);
        
        ds = getDataSource();
    }
    
    @BeforeEach
    public void before() {
        createContainer(ksClient);
    }

    @AfterAll
    public static void tearDown() throws Exception {
        DockerClient docker = DockerClientFactory.instance().client();
        docker.listImagesCmd().withLabelFilter("autodelete=true").exec().stream()
         .filter(c -> c.getId() != null)
         .forEach(c -> docker.removeImageCmd(c.getId()).withForce(true).exec());
    }
    
    @AfterEach
    public void after() throws Exception {
        ksClient.disposeContainer(containerId);
        
        assertEquals("No timer at the table after disposal",
                0, performQuery(SELECT_COUNT_FROM_JBOSS_EJB_TIMER).getInt(1));
    }

    @ParameterizedTest
    @CsvSource({"timer-fail-subprocess,1", "boundary-subprocess,2", "boundary-gateway-subprocess,1"})
    void testEJBTimerWithRollback(String processId, int expectedTimersAfterRollback) throws InterruptedException, SQLException {
        Long processInstanceId = processClient.startProcess(containerId, processId);
        
        assertTrue(processInstanceId>0);
        
        logger.info("Sleeping 1 s");
        Thread.sleep(1000);
        
        assertEquals("there should be just one timer at the table",
                      1, performQuery(SELECT_COUNT_FROM_JBOSS_EJB_TIMER).getInt(1));
        
        logger.info("Sending signal");
        processClient.signal(containerId, "Signal", null);
        
        logger.info("Sleeping 5 s");
        Thread.sleep(5000);
        
        assertEquals("there should be "+expectedTimersAfterRollback+" timer at the table after the rollback",
                      expectedTimersAfterRollback, performQuery(SELECT_COUNT_FROM_JBOSS_EJB_TIMER).getInt(1));
    }
    
    private static void createContainer(KieServicesClient client) {
        ReleaseId releaseId = new ReleaseId(GROUP_ID, ARTIFACT_ID, VERSION);
        KieContainerResource resource = new KieContainerResource(containerId, releaseId);
        resource.setContainerAlias(ARTIFACT_ID + ALIAS);
        client.createContainer(containerId, resource);
    }

    private static KieServicesClient authenticate(int port, String user, String password) {
        String serverUrl = "http://localhost:" + port + "/kie-server/services/rest/server";
        KieServicesConfiguration configuration = KieServicesFactory.newRestConfiguration(serverUrl, user, password);
        
        configuration.setTimeout(60000);
        configuration.setMarshallingFormat(MarshallingFormat.JSON);
        return  KieServicesFactory.newKieServicesClient(configuration);
    }

    private static HikariDataSource getDataSource() {
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setJdbcUrl(postgreSQLContainer.getJdbcUrl());
        hikariConfig.setUsername(postgreSQLContainer.getUsername());
        hikariConfig.setPassword(postgreSQLContainer.getPassword());
        hikariConfig.setDriverClassName(postgreSQLContainer.getDriverClassName());
        
        return new HikariDataSource(hikariConfig);
    }
    
    protected static ResultSet performQuery(String sql) throws SQLException {
        try (Connection conn = ds.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
           ResultSet rs = st.executeQuery();
           rs.next();
           return rs;
        }
    }
    
}

