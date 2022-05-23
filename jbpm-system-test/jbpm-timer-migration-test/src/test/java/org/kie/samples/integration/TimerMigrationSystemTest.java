/*
 * Copyright 2022 Red Hat, Inc. and/or its affiliates.
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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.kie.samples.integration.testcontainers.KieServerContainer;
import org.kie.server.api.marshalling.MarshallingFormat;
import org.kie.server.api.model.KieContainerResource;
import org.kie.server.api.model.ReleaseId;
import org.kie.server.api.model.admin.TimerInstance;
import org.kie.server.client.KieServicesClient;
import org.kie.server.client.KieServicesConfiguration;
import org.kie.server.client.KieServicesFactory;
import org.kie.server.client.ProcessServicesClient;
import org.kie.server.client.admin.ProcessAdminServicesClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.DockerClientFactory;
import org.testcontainers.containers.BindMode;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.github.dockerjava.api.DockerClient;

@Testcontainers(disabledWithoutDocker=true)
class TimerMigrationSystemTest {
    
    public static final String ARTIFACT_ID = "case03200412";
    public static final String GROUP_ID = "example";
    public static final String VERSION = "1.0";
    public static final String ALIAS = "-alias";
    
    public static final String DEFAULT_USER = "kieserver";
    public static final String DEFAULT_PASSWORD = "kieserver1!";

    public static String containerId = GROUP_ID+":"+ARTIFACT_ID+":"+VERSION;

    private static Logger logger = LoggerFactory.getLogger(TimerMigrationSystemTest.class);
    
    protected static Map<String, String> args = new HashMap<>();

    static {
        args.put("IMAGE_NAME", System.getProperty("org.kie.samples.image"));
        args.put("START_SCRIPT", System.getProperty("org.kie.samples.script"));
        args.put("SERVER", System.getProperty("org.kie.samples.server"));
    }
    
    public static Network network = Network.newNetwork();
    
    @Container
    public static MySQLContainer<?> mySQLContainer = new MySQLContainer<>(System.getProperty("org.kie.samples.image.mysql","mysql:latest"))
                                        .withDatabaseName("bpms64kie")
                                        .withUsername("rhpamuser")
                                        .withPassword("rhpampassword")
                                        .withFileSystemBind("src/test/resources/mysql", "/docker-entrypoint-initdb.d",
                                                            BindMode.READ_ONLY)
                                        .withNetwork(network)
                                        .withNetworkAliases("mysql");
    
    public static KieServerContainer kieServer = new KieServerContainer(network, args);
    
    private static KieServicesClient ksClient;
    
    private static ProcessServicesClient processClient;
    private static ProcessAdminServicesClient processAdminClient;
    
    @BeforeAll
    public static void setup() {
        kieServer.start();

        logger.info("KIE Server started at port "+kieServer.getKiePort());
        logger.info("mysql started at "+mySQLContainer.getJdbcUrl());

        ksClient = authenticate(kieServer.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);

        processClient = ksClient.getServicesClient(ProcessServicesClient.class);
        processAdminClient = ksClient.getServicesClient(ProcessAdminServicesClient.class);
    }
    
    @BeforeEach
    public void before() {
        createContainer(ksClient);
    }

    @AfterAll
    public static void tearDown() throws Exception {
        kieServer.stop();
        
        DockerClient docker = DockerClientFactory.instance().client();
        docker.listImagesCmd().withLabelFilter("autodelete=true").exec().stream()
         .filter(c -> c.getId() != null)
         .forEach(c -> docker.removeImageCmd(c.getId()).withForce(true).exec());
    }

    @Test
    void testEJBTimerWithRollback() throws InterruptedException, SQLException {
        Long processInstanceId = processClient.startProcess(containerId, "case03200412.timertest", Collections.singletonMap("timerAlert","2022-10-10T20:00:00.000+02:00"));
        
        assertTrue(processInstanceId>0);
        
        logger.info("Sending signal");
        processClient.signal(containerId, "proceed", null);
        
        List<TimerInstance> timers = processAdminClient.getTimerInstances(containerId, processInstanceId);
        
        assertEquals(1, timers.size());
        
        timers = processAdminClient.getTimerInstances(containerId, 6L);
        
        logger.info("Retrieving timers for process 6; timers[6]: "+timers);
        
        assertEquals(1, timers.size());
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
}

