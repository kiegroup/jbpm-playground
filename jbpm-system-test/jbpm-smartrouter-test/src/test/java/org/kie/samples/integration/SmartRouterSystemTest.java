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

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.stream.Stream;

import com.github.dockerjava.api.DockerClient;
import eu.rekawek.toxiproxy.model.Toxic;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.io.TempDir;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.kie.samples.integration.testcontainers.KieServerContainer;
import org.kie.samples.integration.testcontainers.SmartRouterContainer;
import org.kie.server.api.marshalling.MarshallingFormat;
import org.kie.server.api.model.KieContainerResource;
import org.kie.server.api.model.ReleaseId;
import org.kie.server.client.KieServicesClient;
import org.kie.server.client.KieServicesConfiguration;
import org.kie.server.client.KieServicesFactory;
import org.skyscreamer.jsonassert.JSONAssert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.DockerClientFactory;
import org.testcontainers.containers.BindMode;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.ToxiproxyContainer;
import org.testcontainers.containers.output.WaitingConsumer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;
import org.testcontainers.utility.MountableFile;

import static eu.rekawek.toxiproxy.model.ToxicDirection.DOWNSTREAM;
import static io.restassured.RestAssured.given;
import static io.restassured.http.ContentType.JSON;
import static org.assertj.core.api.Assertions.assertThat;
import static org.awaitility.Awaitility.await;
import static org.awaitility.Duration.ONE_MINUTE;
import static org.kie.samples.integration.testcontainers.KieServerContainer.KIE_HTTPS_PORT;
import static org.kie.samples.integration.testcontainers.KieServerContainer.KIE_PORT;
import static org.testcontainers.containers.output.OutputFrame.OutputType.STDERR;

@Testcontainers(disabledWithoutDocker=true)
class SmartRouterSystemTest {
    
    private static final String ROUTER_TABLE = "kie-server-router.json";
    private static final String REACHED_ATTEMPTS_LIMIT = "has reached reconnect attempts limit";
    private static final String ESCAPED_QUOTE = "\"";
    private static final String LOCATION_NODE1 = "org.kie.samples.server.location.node1";
    private static final String LOCATION_NODE3 = "org.kie.samples.server.location.node3";
    private static final String REST_PATH = "/kie-server/services/rest/server";
    private static final String URL_NODE1 = ESCAPED_QUOTE+System.getProperty(LOCATION_NODE1)+REST_PATH+ESCAPED_QUOTE;
    private static final String URL_NODE3 = ESCAPED_QUOTE+System.getProperty(LOCATION_NODE3)+REST_PATH+ESCAPED_QUOTE;
    public static final String POSTGRESQL_NETWORK_ALIAS = "postgresql11";
    public static final String TOXIPROXY_NETWORK_ALIAS = "toxiproxy";
    
    public static final String GROUP_ID = "org.kie.server.springboot.samples";
    public static final String ARTIFACT_ID = "evaluation";
    public static final String ALIAS = "-alias";
    
    public static final String DEFAULT_USER = "kieserver";
    public static final String DEFAULT_PASSWORD = "kieserver1!";

    public static String containerId = GROUP_ID+":"+ARTIFACT_ID+":";

    private static Logger logger = LoggerFactory.getLogger(SmartRouterSystemTest.class);
    
    protected static Map<String, String> args = new HashMap<>();

    static {
        args.put("IMAGE_NAME_node1", System.getProperty("org.kie.samples.image.node1"));
        args.put("IMAGE_NAME_node3", System.getProperty("org.kie.samples.image.node3"));
        args.put("START_SCRIPT_node1", System.getProperty("org.kie.samples.script.node1"));
        args.put("START_SCRIPT_node3", System.getProperty("org.kie.samples.script.node3"));
        args.put("SERVER_node1", System.getProperty("org.kie.samples.server.node1"));
        args.put("SERVER_node3", System.getProperty("org.kie.samples.server.node3"));
        args.put("KIE_SERVER_LOCATION_node1", System.getProperty(LOCATION_NODE1));
        args.put("KIE_SERVER_LOCATION_node3", System.getProperty(LOCATION_NODE3));
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
                                        .withNetworkAliases(POSTGRESQL_NETWORK_ALIAS);
    
    @Container
    public static ToxiproxyContainer toxiproxy = new ToxiproxyContainer(DockerImageName.parse(System.getProperty("org.kie.samples.image.toxiproxy"))
                                                                        .asCompatibleSubstituteFor("shopify/toxiproxy"))
     .withNetwork(network)
     .withNetworkAliases(TOXIPROXY_NETWORK_ALIAS);
    
    @Container
    public static ToxiproxyContainer toxiproxy3 = new ToxiproxyContainer(DockerImageName.parse(System.getProperty("org.kie.samples.image.toxiproxy"))
                                                                         .asCompatibleSubstituteFor("shopify/toxiproxy"))
     .withNetwork(network)
     .withNetworkAliases(TOXIPROXY_NETWORK_ALIAS+"3");
 
    public static SmartRouterContainer smartRouter; 
    
    public static KieServerContainer kieServer1 = new KieServerContainer("node1", network, args);
    public static KieServerContainer kieServer3 = new KieServerContainer("node3", network, args);
    
    private static KieServicesClient ksClient1;
    private static KieServicesClient ksClient3;
    
    
    @TempDir
    File tempDir;

    private static WaitingConsumer consumerSmartRouter;
    private static RequestSpecification spec;
    
    private static ToxiproxyContainer.ContainerProxy proxy1;
    private static ToxiproxyContainer.ContainerProxy proxy3;
    
    private static String initConfigFile;
    
    private static int reachedLimitCounter;
    
    @BeforeAll
    public static void setup() {
        logger.info("postgresql started at "+postgreSQLContainer.getJdbcUrl());
        
        Map<String, String> extraArgs = new HashMap<>();
        extraArgs.put("KIE_SERVER_CONTROLLER", "http://full-node1:8080/business-central/rest/controller");
        
        smartRouter = new SmartRouterContainer(network, extraArgs);
        smartRouter.start();
        
        spec = new RequestSpecBuilder().setBaseUri("http://"+smartRouter.getContainerIpAddress())
                                       .setPort(smartRouter.getSmartRouterPort())
                                       .build();
        
        kieServer1.start();
        kieServer3.start();

        proxy1 = toxiproxy.getProxy(kieServer1, KIE_HTTPS_PORT);
        logger.info("Toxiproxy (node1) started at port "+proxy1.getProxyPort());
        
        proxy3 = toxiproxy3.getProxy(kieServer3, KIE_PORT);
        logger.info("Toxiproxy (node3) started at port "+proxy3.getProxyPort());

        ksClient1 = authenticate(kieServer1.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);
        createContainer(ksClient1, "1.0.0");
        ksClient3 = authenticate(kieServer3.getKiePort(), DEFAULT_USER, DEFAULT_PASSWORD);
        createContainer(ksClient3, "3.0.0");
        
        logger.info("SMART ROUTER started at port "+smartRouter.getSmartRouterPort());
        logger.info("KIE SERVER 1 started at port "+kieServer1.getKiePort()+" and https at port "+kieServer1.getKieHttpsPort());
        logger.info("KIE SERVER 3 started at port "+kieServer3.getKiePort()+" and https at port "+kieServer3.getKieHttpsPort());
    }
    
    @AfterAll
    public static void tearDown() throws IOException {
        logger.debug("*** After all: tearDown ***");
        
        kieServer1.stop();
        kieServer3.stop();
        
        smartRouter.stop();
        
        Files.deleteIfExists(Paths.get(ROUTER_TABLE));
         
        DockerClient docker = DockerClientFactory.instance().client();
        docker.listImagesCmd().withLabelFilter("autodelete=true").exec().stream()
         .filter(c -> c.getId() != null)
         .forEach(c -> docker.removeImageCmd(c.getId()).withForce(true).exec());
    }
    
    @BeforeEach
    public void before() throws Exception {
        logger.debug("*** Before each ***");
        
        consumerSmartRouter = new WaitingConsumer();
        smartRouter.followOutput(consumerSmartRouter, STDERR);
        
        await().atMost(ONE_MINUTE).untilAsserted(() -> assertThat(readNumberOfContainers()).isEqualTo(2));

        initConfigFile = readConfigFileFromSmartRouter();
        logger.debug("----------------> initConfigFile:: "+initConfigFile);
        
        String logs = smartRouter.getLogs(STDERR);
        reachedLimitCounter = StringUtils.countMatches(logs, REACHED_ATTEMPTS_LIMIT);
    }
    
    @AfterEach
    public void writeConfigFileToContainer() throws Exception {
        logger.debug("*** After each: writeConfigFileToContainer ***");
        
        removeAllToxics(proxy3);
        removeAllToxics(proxy1);
        
        String logs = smartRouter.getLogs(STDERR);
        reachedLimitCounter = StringUtils.countMatches(logs, REACHED_ATTEMPTS_LIMIT);
        
        Path path = Files.write(
                Paths.get(ROUTER_TABLE),
                initConfigFile.getBytes(StandardCharsets.UTF_8));
        //Need to give read/write permissions for all users -0666-
        final MountableFile mountableFile = MountableFile.forHostPath(path, 0666);
        smartRouter.copyFileToContainer(mountableFile, "opt/jboss/");
        
        await().atMost(ONE_MINUTE).until(() -> assertServersInRoutingTable(URL_NODE1, URL_NODE3));
    }
    
    
    private int readNumberOfContainers() throws JSONException {
        JSONObject containers = getContainersFromSmartRouter();
        return containers.has("result") ? 
               containers.getJSONObject("result").getJSONObject("kie-containers").getJSONArray("kie-container").length() : 0;
    }


    private void removeAllToxics(ToxiproxyContainer.ContainerProxy proxy) throws IOException {
        for (Toxic t : proxy.toxics().getAll()) {
            t.remove();
        }
    }
    
    
    private static Stream<Arguments> provideToxics() {
        ToxicSupplier<Toxic, IOException> limitData1 = () -> proxy1.toxics().limitData("limitData", DOWNSTREAM, 5);
        ToxicSupplier<Toxic, IOException> resetPeer1 = () -> proxy1.toxics().resetPeer("resetPeer", DOWNSTREAM, 0);
        ToxicSupplier<Toxic, IOException> timeout1 = () -> proxy1.toxics().timeout("timeout", DOWNSTREAM, getRandomTimeout(0,3000));
        
        ToxicSupplier<Toxic, IOException> limitData3 = () -> proxy3.toxics().limitData("limitData", DOWNSTREAM, 5);
        ToxicSupplier<Toxic, IOException> resetPeer3 = () -> proxy3.toxics().resetPeer("resetPeer", DOWNSTREAM, 0);
        ToxicSupplier<Toxic, IOException> timeout3 = () -> proxy3.toxics().timeout("timeout", DOWNSTREAM, getRandomTimeout(2000,5000));
        
        Stream<Arguments> defaultToxics = Stream.of(Arguments.of(timeout1, resetPeer3));
        
        Stream<Arguments> toxics;
        
        if (Boolean.getBoolean("allToxics")) {
            toxics = Stream.concat(defaultToxics, 
                     Stream.of(Arguments.of(limitData1, null),
                               Arguments.of(resetPeer1, null),
                               Arguments.of(timeout1, null),
                               Arguments.of(null, limitData3),
                               Arguments.of(null, resetPeer3),
                               Arguments.of(null, timeout3),
                               Arguments.of(limitData1, limitData3),
                               Arguments.of(limitData1, resetPeer3),
                               Arguments.of(limitData1, timeout3),
                               Arguments.of(resetPeer1, limitData3),
                               Arguments.of(resetPeer1, resetPeer3),
                               Arguments.of(resetPeer1, timeout3),
                               Arguments.of(timeout1, limitData3),
                               Arguments.of(timeout1, timeout3),
                               Arguments.of(null, null)));
        } else {
            toxics = defaultToxics;
        }
        
        return toxics;
    }
    
    public static int getRandomTimeout(int min, int max) {
        Random random = new Random();
        int timeout = random.ints(min, max).findFirst().getAsInt();
        logger.debug("random timeout is {} ms", timeout);
        return timeout;
    }
    
    @ParameterizedTest
    @MethodSource("provideToxics")
    void shouldUpdateRoutingTableWhenDisconnectedAndReconnected(ToxicSupplier<Toxic, IOException> toxic1, 
                                                                ToxicSupplier<Toxic, IOException> toxic3) throws Exception {
        logger.debug("*** Cut Connection ***");
        
        cutConnection(toxic1, toxic3);
        
        logger.debug("*** Reestablish Connection ***");
        removeAllToxics(proxy1);
        removeAllToxics(proxy3);
        
        await().atMost(ONE_MINUTE).untilAsserted(() -> assertThat(readNumberOfContainers()).isEqualTo(2));
        
        await().atMost(ONE_MINUTE).until(() -> assertServersInRoutingTable(URL_NODE1, URL_NODE3));
    }

    @ParameterizedTest
    @MethodSource("provideToxics")
    void shouldStopPollingWhenReconnectionLimitIsReached(ToxicSupplier<Toxic, IOException> toxic1, 
                                                         ToxicSupplier<Toxic, IOException> toxic3) throws Exception {
        
        logger.debug("*** Cut Connection ***");
        TestFixture fixture = cutConnection(toxic1, toxic3);
        
        if (!fixture.exercisedToxics.isEmpty()) {
            logger.debug("*** Waiting for max_reach ***");
            consumerSmartRouter.waitUntil(frame -> frame.getUtf8String().contains(REACHED_ATTEMPTS_LIMIT), 
                50, TimeUnit.SECONDS, 2-fixture.expectedContainers+reachedLimitCounter);
        }
        
        logger.debug("*** Reestablish Connection ***");
        removeAllToxics(proxy1);
        removeAllToxics(proxy3);
        
        await().atMost(ONE_MINUTE).untilAsserted(() -> assertThat(readNumberOfContainers()).isEqualTo(fixture.expectedContainers));
        
        await().atMost(ONE_MINUTE).until(() -> assertServersInRoutingTable(fixture.expectedServers[1], fixture.expectedServers[3]));
    }

    private TestFixture cutConnection(ToxicSupplier<Toxic, IOException> toxic1, ToxicSupplier<Toxic, IOException> toxic3)
            throws IOException {
        TestFixture fixture = getTestFixture(toxic1, toxic3);
        
        logger.debug("Exercising with toxics:{}", fixture.exercisedToxics);
        logger.debug("expectedContainers:{} and expectedServer1:{} and expectedServer3:{}", 
                      fixture.expectedContainers, fixture.expectedServers[1], fixture.expectedServers[3]);
        
        await().atMost(ONE_MINUTE).untilAsserted(() -> assertThat(readNumberOfContainers()).isEqualTo(fixture.expectedContainers));
        
        final String expected1 = fixture.expectedServers[1];
        final String expected3 = fixture.expectedServers[3];
        
        await().atMost(ONE_MINUTE).until(() -> assertServersInRoutingTable(expected1, expected3));
        
        return fixture;
    }
    
    private TestFixture getTestFixture(ToxicSupplier<Toxic, IOException> toxic1, ToxicSupplier<Toxic, IOException> toxic3) throws IOException {
        Toxic exercisedToxic1;
        Toxic exercisedToxic3;
        
        TestFixture toxicFixture = new TestFixture();
        
        if (toxic1 != null) {
            exercisedToxic1 = toxic1.get();
            toxicFixture.exercisedToxics = exercisedToxic1.getName();
        } else {
            toxicFixture.expectedContainers++;
            toxicFixture.expectedServers[1] = URL_NODE1;
        }
        
        if (toxic3 != null) {
            exercisedToxic3 = toxic3.get();
            toxicFixture.exercisedToxics = toxicFixture.exercisedToxics.isEmpty()? exercisedToxic3.getName()
                                                                                 : toxicFixture.exercisedToxics.concat(" and ").concat(exercisedToxic3.getName());
        } else {
            toxicFixture.expectedContainers++;
            toxicFixture.expectedServers[3] = URL_NODE3;
        }
        return toxicFixture;
    }

    @FunctionalInterface
    public interface ToxicSupplier<T, E extends Exception> {
        T get() throws E;
    }

    private JSONObject getContainersFromSmartRouter() throws JSONException {
        Response res = given()
        .contentType(JSON)
        .accept(JSON)
        .auth()
        .preemptive()
        .basic("kieserver", "kieserver1!")
        .spec(spec)
        .when()
        .get("/containers")
        .then()
        .extract()
        .response();

        logger.trace(" /containers response from smart-router:: "+res.asPrettyString());
        
        String result = res.asString().isEmpty()? "{}" : res.asString();
        
        return new JSONObject(result);
    }


    private boolean assertServersInRoutingTable(String expectedNode1, final String expectedNode3) throws Exception {
        String content = readConfigFileFromSmartRouter();
        
        logger.debug("kie-server-router.json :: "+content);
        JSONObject data = new JSONObject(content);
        
        String expected = "{servers:[{kie-server-node3:["+expectedNode3+"]},"+
                                    "{full-node1:["+expectedNode1+"]}]}";
        
        JSONAssert.assertEquals(expected, data, false);
        return true;
    }

    private String readConfigFileFromSmartRouter() throws Exception {
        File actualFile = new File(tempDir.getAbsolutePath() + "/router.json");
        smartRouter.copyFileFromContainer("opt/jboss/kie-server-router.json", actualFile.getPath());
        return new String(Files.readAllBytes(Paths.get(tempDir.getAbsolutePath() + "/router.json")));
    }
    
    private static void createContainer(KieServicesClient client, String version) {
        ReleaseId releaseId = new ReleaseId(GROUP_ID, ARTIFACT_ID, version);
        KieContainerResource resource = new KieContainerResource(containerId+version, releaseId);
        resource.setContainerAlias(ARTIFACT_ID + "-"+version + ALIAS);
        client.createContainer(containerId+version, resource);
    }

    private static KieServicesClient authenticate(int port, String user, String password) {
        String serverUrl = "http://localhost:" + port + REST_PATH;
        KieServicesConfiguration configuration = KieServicesFactory.newRestConfiguration(serverUrl, user, password);
        
        configuration.setTimeout(60000);
        configuration.setMarshallingFormat(MarshallingFormat.JSON);
        return  KieServicesFactory.newKieServicesClient(configuration);
    }
    
    public class TestFixture {
        String exercisedToxics = "";
        int expectedContainers = 0;
        String[] expectedServers = {"", "", "", ""};
    }
}

