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

package org.kie.samples.integration.testcontainers;

import java.time.Duration;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.output.Slf4jLogConsumer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.images.builder.ImageFromDockerfile;

public class SmartRouterContainer extends GenericContainer<SmartRouterContainer>{

    private static final String SMARTROUTER_ALIAS = "smartrouter";
    private static final int SMARTROUTER_PORT = 9000;

    private static Logger logger = LoggerFactory.getLogger(SmartRouterContainer.class);

    public SmartRouterContainer(Network network, Map<String,String> args) {
      super( new ImageFromDockerfile()
          .withBuildArg("BRANCH", System.getProperty("org.kie.samples.image.smartrouter.branch"))
          .withBuildArg("REPO_URL", System.getProperty("org.kie.samples.image.smartrouter.repo_url"))
              
          .withFileFromClasspath("logging.properties", "etc/logging.properties")
          .withFileFromClasspath("smart_router.properties", "etc/smart_router.properties")
          .withFileFromClasspath("Dockerfile", "etc/smart_router.Dockerfile")
          .withFileFromClasspath("etc/kieks.crt", "etc/kieks.crt")
          .withFileFromClasspath("etc/serverks.pkcs12", "etc/serverks.pkcs12"));

      if (args.get("KIE_SERVER_CONTROLLER")!=null && !args.get("KIE_SERVER_CONTROLLER").isEmpty()) {
          withEnv("KIE_SERVER_CONTROLLER", args.get("KIE_SERVER_CONTROLLER"));
      }

      withEnv("ROUTER_PROPS", "-Djava.util.logging.config.file=$ROUTER_HOME/logging.properties "+
                              "-Dorg.kie.server.router.config.watcher.enabled=true "+
                              "-Dorg.kie.server.router.config.file=$ROUTER_HOME/smart_router.properties "+
                              "-Djavax.net.ssl.trustStore=$ROUTER_HOME/serverks.pkcs12 "+
                              "-Djavax.net.ssl.trustStorePassword=secret");

      withNetwork(network);
      withNetworkAliases(SMARTROUTER_ALIAS);
      withExposedPorts(SMARTROUTER_PORT);
      withLogConsumer(new Slf4jLogConsumer(logger).withPrefix("SMART-ROUTER"));
      
      waitingFor(Wait.forLogMessage(".*KieServerRouter started on.*", 1).withStartupTimeout(Duration.ofMinutes(2L)));
    }
    
    public Integer getSmartRouterPort() {
        return this.getMappedPort(SMARTROUTER_PORT);
    }
}
