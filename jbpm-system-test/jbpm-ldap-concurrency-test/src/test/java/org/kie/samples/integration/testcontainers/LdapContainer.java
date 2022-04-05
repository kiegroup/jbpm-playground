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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testcontainers.containers.BindMode;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.output.Slf4jLogConsumer;

public class LdapContainer extends GenericContainer<LdapContainer>{

    private static final Logger logger = LoggerFactory.getLogger(LdapContainer.class);

    private static final int LDAP_PORT = 389;
    
    
    /**
     * Create a LdapContainer by passing the full docker image name
     *
     */
    public LdapContainer(Network network) {
       super(System.getProperty("org.kie.samples.image.openldap","osixia/openldap:latest"));
       withNetwork(network);
       withNetworkAliases("ldap-alias");
       withExposedPorts(LDAP_PORT);
       withEnv("LDAP_DOMAIN","jbpm.org");
       if (System.getProperty("ldapLog") != null)
          withLogConsumer(new Slf4jLogConsumer(logger).withPrefix("LDAP-LOG"));
       withClasspathResourceMapping("etc/ldap/jbpm.ldif", "/container/service/slapd/assets/config/bootstrap/ldif/custom/jbpm.ldif", BindMode.READ_ONLY);
       withCommand("--copy-service");
    }

    public Integer getLdapPort() {
        return this.getMappedPort(LDAP_PORT);
    }
    
}

