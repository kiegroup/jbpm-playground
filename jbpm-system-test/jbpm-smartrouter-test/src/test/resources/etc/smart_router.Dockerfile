#########################################################
# Dockerfile that provides the image for KIE Smart Router
#########################################################

ARG BRANCH
ARG REPO_URL

FROM openjdk:18-ea-11-alpine AS builder

ENV ROUTER_HOME=/opt/jboss 

# Create a jboss user and group
RUN addgroup -S jboss && adduser -S jboss -G jboss && \
    mkdir $ROUTER_HOME && \
    chmod 777 $ROUTER_HOME

# Set the working directory to jboss' user home directory
WORKDIR ROUTER_HOME

USER root

ARG BRANCH
ARG REPO_URL

ADD etc/kieks.crt $ROUTER_HOME/kieks.crt
ADD etc/serverks.pkcs12 $ROUTER_HOME/serverks.pkcs12

RUN $JAVA_HOME/bin/keytool -importcert -noprompt -trustcacerts -alias toxiproxy-full-ks -file \
    $ROUTER_HOME/kieks.crt -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit

RUN apk add git
RUN apk add maven

USER jboss

RUN mkdir $ROUTER_HOME/repo-clone

RUN git clone -b $BRANCH --single-branch $REPO_URL $ROUTER_HOME/repo-clone

RUN mvn -f $ROUTER_HOME/repo-clone/kie-server-parent/kie-server-router/kie-server-router-proxy/pom.xml clean install \
    -DskipTests -Dmaven.source.skip -Dmaven.test.skip

RUN cp $ROUTER_HOME/repo-clone/kie-server-parent/kie-server-router/kie-server-router-proxy/target/kie-server-router-proxy-*.jar \
    $ROUTER_HOME/kie-server-router.jar

ADD smart_router.properties $ROUTER_HOME/smart_router.properties
ADD logging.properties $ROUTER_HOME/logging.properties

WORKDIR $ROUTER_HOME

CMD "sh" "-c" "/usr/bin/java -jar $ROUTER_PROPS $ROUTER_HOME/kie-server-router.jar"
