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

import java.io.File;
import java.time.Duration;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.output.Slf4jLogConsumer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.images.builder.ImageFromDockerfile;

public class KieServerContainer extends GenericContainer<KieServerContainer>{

    private static Logger logger = LoggerFactory.getLogger(KieServerContainer.class);

    private static final int KIE_PORT = 8080;
    
    public KieServerContainer(Network network, Map<String,String> args) {
      super( new ImageFromDockerfile()
           .withBuildArg("IMAGE_NAME", args.get("IMAGE_NAME"))
           .withBuildArg("SERVER", args.get("SERVER"))
           .withBuildArg("NO_PATCH", System.getProperty("noPatch"))
           .withFileFromClasspath("etc/jbpm-custom.cli", "etc/ldap/jbpm-custom-"+args.get("SERVER")+".cli")
           .withFileFromClasspath("etc/jbpm.user.info.properties", "etc/jbpm.user.info.properties")
           .withFileFromClasspath("etc/jbpm.usergroup.callback.properties", "etc/jbpm.usergroup.callback.properties")
           .withFileFromClasspath("etc/jbpm-human-task-core-7.67.0.Final.jar", "etc/jbpm-human-task-core-7.67.0.Final.jar")
           .withFileFromClasspath("etc/kjars", "etc/kjars")
           .withFileFromClasspath("Dockerfile", "etc/ldap/Dockerfile")
           .withFileFromFile("etc/drivers/postgresql.jar", new File("target/drivers").listFiles()[0]));
    
      withEnv("START_SCRIPT", args.get("START_SCRIPT"));
      withNetwork(network);
      withNetworkAliases("kie-server");
      withExposedPorts(KIE_PORT);
      withLogConsumer(new Slf4jLogConsumer(logger).withPrefix("KIE-LOG"));
      waitingFor(Wait.forLogMessage(".*WildFly.*started in.*", 1).withStartupTimeout(Duration.ofMinutes(5L)));
    }
    
    public Integer getKiePort() {
        return this.getMappedPort(KIE_PORT);
    }
}
