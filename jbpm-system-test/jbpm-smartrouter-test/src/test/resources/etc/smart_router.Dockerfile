#########################################################
# Dockerfile that provides the image for KIE Smart Router
#########################################################

ARG BRANCH
ARG REPO_URL

FROM jboss/base-jdk:11

ENV ROUTER_HOME=/opt/jboss 

USER root
RUN yum install git -y
RUN yum install maven -y

ARG BRANCH
ARG REPO_URL

RUN mkdir /repo-clone
RUN git clone -b $BRANCH --single-branch $REPO_URL /repo-clone

RUN mvn -f /repo-clone/kie-server-parent/kie-server-router/kie-server-router-proxy/pom.xml clean install \
    -DskipTests -Dmaven.source.skip -Dmaven.test.skip

ADD etc/kieks.crt $ROUTER_HOME/kieks.crt
ADD etc/serverks.pkcs12 $ROUTER_HOME/serverks.pkcs12

RUN $JAVA_HOME/bin/keytool -importcert -noprompt -trustcacerts -alias toxiproxy-full-ks -file \
    $ROUTER_HOME/kieks.crt -keystore /etc/pki/java/cacerts -storepass changeit

USER jboss
RUN cp /repo-clone/kie-server-parent/kie-server-router/kie-server-router-proxy/target/kie-server-router-proxy-*.jar \
    $ROUTER_HOME/kie-server-router.jar

ADD smart_router.properties $ROUTER_HOME/smart_router.properties
ADD logging.properties $ROUTER_HOME/logging.properties

WORKDIR $ROUTER_HOME

CMD "sh" "-c" "/usr/bin/java -jar $ROUTER_PROPS $ROUTER_HOME/kie-server-router.jar"
