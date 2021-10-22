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

import static io.restassured.RestAssured.given;
import static java.time.ZoneOffset.UTC;
import static java.time.ZonedDateTime.now;
import static java.time.format.DateTimeFormatter.ISO_INSTANT;
import static java.time.temporal.ChronoUnit.SECONDS;
import static java.util.Collections.singletonMap;
import static org.awaitility.Awaitility.await;
import static org.awaitility.Duration.FIVE_SECONDS;
import static org.awaitility.Duration.ONE_MINUTE;
import static org.hamcrest.CoreMatchers.hasItem;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.Matchers.equalTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.Map;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
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
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.output.Slf4jLogConsumer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.github.dockerjava.api.DockerClient;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;

@Testcontainers(disabledWithoutDocker=true)
class DuplicatedDeadlinesSystemTest {
    
    public static final String SELECT_COUNT_FROM_JBOSS_EJB_TIMER = "select count(*) from jboss_ejb_timer";
    public static final String DEADLINE_ARTIFACT_ID = "deadline-sample";
    public static final String NO_NOTIF_ARTIFACT_ID = "no-notif-sample";
    public static final String GROUP_ID = "org.kie.server.testing";
    public static final String VERSION = "1.0.0";
    public static final String ALIAS = "-alias";
    
    public static final String DEFAULT_USER = "kieserver";
    public static final String DEFAULT_PASSWORD = "kieserver1!";

    public static final String DEADLINE_CONTAINER_ID = GROUP_ID+":"+DEADLINE_ARTIFACT_ID+":"+VERSION;
    public static final String NO_NOTIF_CONTAINER_ID = GROUP_ID+":"+NO_NOTIF_ARTIFACT_ID+":"+VERSION;

    private static Logger logger = LoggerFactory.getLogger(DuplicatedDeadlinesSystemTest.class);
    
    private static Map<String, String> args = new HashMap<>();

    static {
        args.put("IMAGE_NAME", System.getProperty("org.kie.samples.image"));
        args.put("START_SCRIPT", System.getProperty("org.kie.samples.script"));
        args.put("SERVER", System.getProperty("org.kie.samples.server"));
    }

    public static Network network = Network.newNetwork();
    
    public static PostgreSQLContainer<?> postgreSQLContainer = new PostgreSQLContainer<>(System.getProperty("org.kie.samples.image.postgresql","postgres:latest"))
                                        .withDatabaseName("rhpamdatabase")
                                        .withUsername("rhpamuser")
                                        .withPassword("rhpampassword")
                                        .withFileSystemBind("target/postgresql", "/docker-entrypoint-initdb.d",
                                                            BindMode.READ_ONLY)
                                        .withNetwork(network)
                                        .withNetworkAliases("postgresql11");

    public static KieServerContainer kieServer = new KieServerContainer("node1", network, args);
    
    private static final Integer PORT_SMTP = 1025;
    private static final Integer PORT_HTTP = 8025;

    private static Integer smtpPort;
    private static String smtpHost;

    @Container
    public static GenericContainer<?> mailhog = new GenericContainer<>("mailhog/mailhog:latest")
        .withExposedPorts(PORT_SMTP, PORT_HTTP)
        .withNetwork(network)
        .withNetworkAliases("mailhog")
        .withLogConsumer(new Slf4jLogConsumer(logger))
        .waitingFor(Wait.forHttp("/"));
    
    private static KieServicesClient ksClient;
    
    private static ProcessServicesClient processClient;
    
    private static HikariDataSource ds;
    
    private static RequestSpecification specV1;
    private static RequestSpecification specV2;
    
    @BeforeAll
    public static void setup() {
        smtpPort = mailhog.getMappedPort(PORT_SMTP);
        smtpHost = mailhog.getContainerIpAddress();
        Integer httpPort = mailhog.getMappedPort(PORT_HTTP);

        logger.info("Mailhog started at SMTP host/port: "+smtpHost+":"+smtpPort);
        
        //There's no DELETE operation at v2. Therefore, two different basePaths (/api/v2, /api/v1) 
        //will be set up for each endpoint in the REST-assured RequestSpecification.
        specV1 = new RequestSpecBuilder().setBaseUri("http://"+smtpHost).setPort(httpPort).setBasePath("/api/v1").build();
        specV2 = new RequestSpecBuilder().setBaseUri("http://"+smtpHost).setPort(httpPort).setBasePath("/api/v2").build();
    }
    
    @BeforeEach
    public void before() throws Exception {
        postgreSQLContainer.start();
        ds = getDataSource();
        
        kieServer.start();
        
        checkTimersInDatabase(0);
        
        logger.info("KIE SERVER started at port "+kieServer.getKiePort());
        logger.info("postgresql started at "+postgreSQLContainer.getJdbcUrl());
        
        ksClient = authenticate(kieServer.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);
        
        processClient = ksClient.getServicesClient(ProcessServicesClient.class);
        
        createContainer(ksClient, DEADLINE_ARTIFACT_ID, DEADLINE_CONTAINER_ID);
        
        checkTimersInDatabase(0);
    }
    
    @AfterEach
    public void after() {
        kieServer.stop();
        //Keep the list of messages clean after each test
        given().spec(specV1).when().delete("/messages");
        
        postgreSQLContainer.stop();
    }

    @AfterAll
    public static void tearDown() throws Exception {
        DockerClient docker = DockerClientFactory.instance().client();
        docker.listImagesCmd().withLabelFilter("autodelete=true").exec().stream()
         .filter(c -> c.getId() != null)
         .forEach(c -> docker.removeImageCmd(c.getId()).withForce(true).exec());
    }

    @ParameterizedTest
    @ValueSource(ints = {40, 5})
    @DisplayName("Deadline notifications are received once and only once after server restart")
    void testDeadlineNotificationsAfterRestart(int triggerInterval) throws Exception {
        ZonedDateTime triggerTime = now(UTC).plus(triggerInterval, SECONDS);
        
        startProcess("notificationTest.notification", triggerTime.format(ISO_INSTANT));
        
        checkTimersInDatabase(3);
        
        //no email messages received yet 
        checkNoReceivedEmails();
        
        restartKieServer();
        
        //Deploy same container
        createContainer(ksClient, DEADLINE_ARTIFACT_ID, DEADLINE_CONTAINER_ID);
        
        waitFrom(triggerTime, 10);
        
        given()
          .spec(specV2)
          .when()
          .get("/messages")
          .then()
          .body("total", equalTo(3))
          .assertThat().body("items[0].Content.Headers.To", hasItem("administrator@jbpm.org, wbadmin@jbpm.org"))
          .assertThat().body("items[0].Content.Headers.From", hasItem("john@jbpm.org"))
          .assertThat().body("items[0].Content.Headers.Subject", hasItem("foo"))
          .assertThat().body("items[0].Content.Body", is("bar"));
        
        checkTimersInDatabase(0);
    }

    @ParameterizedTest
    @ValueSource(ints = {40, 10})
    @DisplayName("Deadline notifications are not received after server restart but deployed a different container")
    void testNoDeadlineNotificationsAfterRestartWithDifferentContainer(int triggerInterval) throws Exception {
        ZonedDateTime triggerTime = now(UTC).plus(triggerInterval, SECONDS);
        startProcess("notificationTest.notification", triggerTime.format(ISO_INSTANT));
        
        checkTimersInDatabase(3);
        
        checkNoReceivedEmails();
        
        restartKieServer();
        
        //Deploy a different container without deadline notifications
        createContainer(ksClient, NO_NOTIF_ARTIFACT_ID, NO_NOTIF_CONTAINER_ID);
        
        waitFrom(triggerTime, 10);
        
        checkNoReceivedEmails();
        
        checkTimersInDatabase(3);
    }

    private void checkTimersInDatabase(int expectedNumberOfTimers) throws SQLException {
        assertEquals("there should be "+expectedNumberOfTimers+" timers at the table for deadlines",
                     expectedNumberOfTimers, performQuery(SELECT_COUNT_FROM_JBOSS_EJB_TIMER).getInt(1));
    }

    private static void createContainer(KieServicesClient client, String artifactId, String containerId) {
        ReleaseId releaseId = new ReleaseId(GROUP_ID, artifactId, VERSION);
        KieContainerResource resource = new KieContainerResource(containerId, releaseId);
        resource.setContainerAlias(artifactId + ALIAS);
        client.createContainer(containerId, resource);
    }

    private static KieServicesClient authenticate(int port, String user, String password) {
        String serverUrl = "http://localhost:" + port + "/kie-server/services/rest/server";
        KieServicesConfiguration configuration = KieServicesFactory.newRestConfiguration(serverUrl, user, password);
        
        configuration.setTimeout(60000);
        configuration.setMarshallingFormat(MarshallingFormat.JSON);
        return  KieServicesFactory.newKieServicesClient(configuration);
    }

    private Long startProcess(String processName, String nowStr) {
        logger.info("Current time for invoking process: "+nowStr);
        Long processInstanceId = processClient.startProcess(DEADLINE_CONTAINER_ID, processName, singletonMap("notificationExpression", "R3/"+nowStr+"/PT3S"));
        assertNotNull(processInstanceId);
        return processInstanceId;
    }
    
    private void checkNoReceivedEmails() {
        given().spec(specV2).when().get("/messages")
        .then().body("total", equalTo(0));
    }
    
    private void waitFrom(ZonedDateTime initTime, int duration) {
        await()
           .pollDelay(FIVE_SECONDS) // give some delay for mailhog to receive the emails in case of immediate trigger
           .atMost(ONE_MINUTE)
           .until(() -> { 
                return now(UTC).isAfter(initTime.plus(duration, SECONDS));
            });;
    }

    private void restartKieServer() {
        kieServer.stop();
        kieServer = new KieServerContainer("node1", network, args);
        kieServer.start();
        logger.info("KIE SERVER 1 restarted at port "+kieServer.getKiePort());
        
        ksClient = authenticate(kieServer.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);
    }
    
    private static HikariDataSource getDataSource() {
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setJdbcUrl(postgreSQLContainer.getJdbcUrl());
        hikariConfig.setUsername(postgreSQLContainer.getUsername());
        hikariConfig.setPassword(postgreSQLContainer.getPassword());
        hikariConfig.setDriverClassName(postgreSQLContainer.getDriverClassName());
        
        return new HikariDataSource(hikariConfig);
    }
    
    protected ResultSet performQuery(String sql) {
        try (Connection conn = ds.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
           ResultSet rs = st.executeQuery();
           rs.next();
           return rs;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

