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

import static java.util.Collections.singletonMap;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.RepeatedTest;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;
import org.kie.samples.integration.testcontainers.KieServerContainer;
import org.kie.samples.integration.testcontainers.LdapContainer;
import org.kie.server.api.marshalling.MarshallingFormat;
import org.kie.server.api.model.KieContainerResource;
import org.kie.server.api.model.ReleaseId;
import org.kie.server.api.model.instance.ProcessInstance;
import org.kie.server.client.KieServicesClient;
import org.kie.server.client.KieServicesConfiguration;
import org.kie.server.client.KieServicesFactory;
import org.kie.server.client.ProcessServicesClient;
import org.kie.server.client.QueryServicesClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.DockerClientFactory;
import org.testcontainers.containers.BindMode;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.github.dockerjava.api.DockerClient;

@Testcontainers(disabledWithoutDocker=true)
@Execution(ExecutionMode.CONCURRENT)
class LdapConcurrencySystemTest {
    
public static final String ARTIFACT_ID = "ldap-sample";
    public static final String GROUP_ID = "org.kie.server.testing";
    public static final String VERSION = "1.0.0";
    public static final String ALIAS = "-alias";
    
    public static final String USER_WITH_GUARD_ROLE = "Bartlet";
    public static final String GUARD_ROLE_USER_PASSWORD = "123456";

    public static String containerId = GROUP_ID+":"+ARTIFACT_ID+":"+VERSION;

    private static Logger logger = LoggerFactory.getLogger(LdapConcurrencySystemTest.class);
    
    private static Map<String, String> args = new HashMap<>();

    static {
        args.put("IMAGE_NAME", System.getProperty("org.kie.samples.image"));
        args.put("START_SCRIPT", System.getProperty("org.kie.samples.script"));
        args.put("SERVER", System.getProperty("org.kie.samples.server"));
    }

    public static Network network = Network.newNetwork();
    
    @Container
    public static LdapContainer ldap = new LdapContainer(network);
    
    @Container
    public static PostgreSQLContainer<?> postgreSQLContainer = new PostgreSQLContainer<>(System.getProperty("org.kie.samples.image.postgresql","postgres:latest"))
                                        .withDatabaseName("rhpamdatabase")
                                        .withUsername("rhpamuser")
                                        .withPassword("rhpampassword")
                                        .withFileSystemBind("target/postgresql", "/docker-entrypoint-initdb.d",
                                                            BindMode.READ_ONLY)
                                        .withNetwork(network)
                                        .withNetworkAliases("postgresql11");

    @Container
    public static KieServerContainer kieServer = new KieServerContainer(network, args);
    
    private static KieServicesClient ksClient;
    
    @BeforeAll
    public static void setup() {
        logger.info("KIE SERVER started at port "+kieServer.getKiePort());
        logger.info("LDAP started at port "+ldap.getLdapPort());
        
        ksClient = authenticate(USER_WITH_GUARD_ROLE, GUARD_ROLE_USER_PASSWORD);
        
        createContainer(ksClient);
    }

    @AfterAll
    public static void tearDown() {
        DockerClient docker = DockerClientFactory.instance().client();
        docker.listImagesCmd().withLabelFilter("autodelete=true").exec().stream()
         .filter(c -> c.getId() != null)
         .forEach(c -> docker.removeImageCmd(c.getId()).withForce(true).exec());
    }

    @DisplayName("when user logged in has guardRole then restricted var can be changed")
    @RepeatedTest(50)
    void whenUserLoggedInHasGuardRoleThenRestrictedVarCanBeChanged() {
        
        ProcessServicesClient processClient = ksClient.getServicesClient(ProcessServicesClient.class);
        
        Long id = processClient.startProcess(containerId, "HumanTaskWithRestrictedVar", singletonMap("press", "true"));
        
        assertNotNull(id);
        abortProcess(ksClient, processClient, id);
    }

   
    private static void createContainer(KieServicesClient client) {
        ReleaseId releaseId = new ReleaseId(GROUP_ID, ARTIFACT_ID, VERSION);
        KieContainerResource resource = new KieContainerResource(containerId, releaseId);
        resource.setContainerAlias(ARTIFACT_ID + ALIAS);
        client.createContainer(containerId, resource);
    }

    private static KieServicesClient authenticate(String user, String password) {
        String serverUrl = "http://localhost:" + kieServer.getKiePort() + "/kie-server/services/rest/server";
        KieServicesConfiguration configuration = KieServicesFactory.newRestConfiguration(serverUrl, user, password);
        
        configuration.setTimeout(60000);
        configuration.setMarshallingFormat(MarshallingFormat.JSON);
        return  KieServicesFactory.newKieServicesClient(configuration);
    }
    
    private void abortProcess(KieServicesClient kieServicesClient, ProcessServicesClient processClient, Long processInstanceId) {
        QueryServicesClient queryClient = kieServicesClient.getServicesClient(QueryServicesClient.class);
        
        ProcessInstance processInstance = queryClient.findProcessInstanceById(processInstanceId);
        assertNotNull(processInstance);
        assertEquals(1, processInstance.getState().intValue());
        processClient.abortProcessInstance(containerId, processInstanceId);
    }
}

