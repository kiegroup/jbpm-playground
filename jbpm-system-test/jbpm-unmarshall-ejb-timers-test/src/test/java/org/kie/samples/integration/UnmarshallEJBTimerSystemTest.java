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

import static java.util.Collections.singletonMap;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
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
class UnmarshallEJBTimerSystemTest {
    
    public static final String SELECT_PARTITION_NAME_FROM_JBOSS_EJB_TIMER = "select partition_name from jboss_ejb_timer";
    public static final String PREFIX_CLI_PATH = "src/test/resources/etc/jbpm-custom-";
    public static final String SELECT_COUNT_FROM_JBOSS_EJB_TIMER = "select count(*) from jboss_ejb_timer";
    public static final String ARTIFACT_ID = "unmarshall-ejb-sample";
    public static final String GROUP_ID = "org.kie.server.testing";
    public static final String VERSION = "1.0.0";
    public static final String ALIAS = "-alias";
    
    public static final String DEFAULT_USER = "kieserver";
    public static final String DEFAULT_PASSWORD = "kieserver1!";

    public static final String CONTAINER_ID = GROUP_ID+":"+ARTIFACT_ID+":"+VERSION;

    private static Logger logger = LoggerFactory.getLogger(UnmarshallEJBTimerSystemTest.class);
    
    private static Map<String, String> args = new HashMap<>();

    static {
        args.put("IMAGE_NAME", System.getProperty("org.kie.samples.image"));
        args.put("START_SCRIPT", System.getProperty("org.kie.samples.script"));
        args.put("SERVER", System.getProperty("org.kie.samples.server"));
        createCLIFile("node1");
        createCLIFile("node2");
    }

    public static Network network = Network.newNetwork();
    
    @Container
    public static PostgreSQLContainer<?> postgreSQLContainer = new PostgreSQLContainer<>(System.getProperty("org.kie.samples.image.postgresql","postgres:latest"))
                                        .withDatabaseName("rhpamdatabase")
                                        .withUsername("rhpamuser")
                                        .withPassword("rhpampassword")
                                        .withFileSystemBind("target/postgresql", "/docker-entrypoint-initdb.d",
                                                            BindMode.READ_ONLY)
                                        .withNetwork(network)
                                        .withNetworkAliases("postgresql11");

    public static KieServerContainer kieServer1 = new KieServerContainer("node1", network, args);
    
    public static KieServerContainer kieServer2 = new KieServerContainer("node2", network, args);
    
    private static KieServicesClient ksClient1;
    private static KieServicesClient ksClient2;
    
    private static ProcessServicesClient processClient1;
    private static ProcessServicesClient processClient2;
    
    private static HikariDataSource ds;
    
    @BeforeAll
    public static void setup() {
        logger.info("postgresql started at "+postgreSQLContainer.getJdbcUrl());
        kieServer1.start();
        kieServer2.start();
        logger.info("KIE SERVER 1 started at port "+kieServer1.getKiePort());
        logger.info("KIE SERVER 2 started at port "+kieServer2.getKiePort());
        
        ksClient1 = authenticate(kieServer1.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);
        ksClient2 = authenticate(kieServer2.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);
        
        processClient1 = ksClient1.getServicesClient(ProcessServicesClient.class);
        processClient2 = ksClient2.getServicesClient(ProcessServicesClient.class);
        
        ds = getDataSource();
    }
    
    @BeforeEach
    public void before() {
        createContainer(ksClient1);
        createContainer(ksClient2);
    }
    
    @AfterEach
    public void clean() {
        ksClient1.disposeContainer(CONTAINER_ID);
        ksClient2.disposeContainer(CONTAINER_ID);
    }
    
    @AfterAll
    public static void tearDown() {
        kieServer1.stop();
        kieServer2.stop();
        DockerClient docker = DockerClientFactory.instance().client();
        docker.listImagesCmd().withLabelFilter("autodelete=true").exec().stream()
         .filter(c -> c.getId() != null)
         .forEach(c -> docker.removeImageCmd(c.getId()).withForce(true).exec());
    }

    @Test
    @DisplayName("user starts process in one node but get variable in another before refresh-time")
    void getVariableBeforeRefresh() throws Exception {
        Long processInstanceId = startProcessInNode1("ht-timer-process");
        
        findVariableInNode2(processInstanceId);
        
        assertEquals("there should be just one timer at the table",
                      1, performQuery(SELECT_COUNT_FROM_JBOSS_EJB_TIMER).getInt(1));
        
        assertEquals("timer should be started at node1 partition",
                     "ejb_timer_node1_part", performQuery(SELECT_PARTITION_NAME_FROM_JBOSS_EJB_TIMER).getString(1));
        
    }

    private static void createContainer(KieServicesClient client) {
        ReleaseId releaseId = new ReleaseId(GROUP_ID, ARTIFACT_ID, VERSION);
        KieContainerResource resource = new KieContainerResource(CONTAINER_ID, releaseId);
        resource.setContainerAlias(ARTIFACT_ID + ALIAS);
        client.createContainer(CONTAINER_ID, resource);
    }

    private static void createCLIFile(String nodeName) {
        Boolean noCluster = Boolean.getBoolean("org.kie.samples.ejbtimer.nocluster");
        //if different partitions are defined per nodeName, then there is no cluster for EJB timers
        String node = noCluster? nodeName : "node1";
        try {
             String content = FileUtils.readFileToString(new File(PREFIX_CLI_PATH+"template.cli"), "UTF-8");
             content = content.replaceAll("%partition_name%", "\\\"ejb_timer_"+node+"_part\\\"");
             File cliFile = new File(PREFIX_CLI_PATH+nodeName+".cli");
             FileUtils.writeStringToFile(cliFile, content, "UTF-8");
             cliFile.deleteOnExit();
          } catch (IOException e) {
             throw new RuntimeException("Generating file failed", e);
          }
    }

    private static KieServicesClient authenticate(int port, String user, String password) {
        String serverUrl = "http://localhost:" + port + "/kie-server/services/rest/server";
        KieServicesConfiguration configuration = KieServicesFactory.newRestConfiguration(serverUrl, user, password);
        
        configuration.setTimeout(60000);
        configuration.setMarshallingFormat(MarshallingFormat.JSON);
        return  KieServicesFactory.newKieServicesClient(configuration);
    }

    private Long startProcessInNode1(String processName) {
        Long processInstanceId = processClient1.startProcess(CONTAINER_ID, processName, singletonMap("duration", "PT30S"));
        assertNotNull(processInstanceId);
        return processInstanceId;
    }
    
    private void findVariableInNode2(Long processInstanceId) {
        Object instanceVar = processClient2.getProcessInstanceVariable(CONTAINER_ID, processInstanceId, "duration");
        logger.info("Find variable duration with value {} on kieserver2", instanceVar);
        assertNotNull(instanceVar);
    }

    private static HikariDataSource getDataSource() {
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setJdbcUrl(postgreSQLContainer.getJdbcUrl());
        hikariConfig.setUsername(postgreSQLContainer.getUsername());
        hikariConfig.setPassword(postgreSQLContainer.getPassword());
        hikariConfig.setDriverClassName(postgreSQLContainer.getDriverClassName());
        
        return new HikariDataSource(hikariConfig);
    }
    
    protected ResultSet performQuery(String sql) throws SQLException {
        try (Connection conn = ds.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
           ResultSet rs = st.executeQuery();
           rs.next();
           return rs;
        }
    }
    
}

