# Multi-stage Dockerfile

# First, build kjar from a maven image

ARG IMAGE_NAME

FROM maven:3.6.3-openjdk-8-slim as builder
LABEL autodelete="true"
COPY etc/kjars/ /etc/kjars/
RUN mvn --file /etc/kjars/cluster-ejb-sample/pom.xml --batch-mode install -DskipTests

#########################################################
# Dockerfile that provides the image for KIE Server
#########################################################

FROM $IMAGE_NAME

RUN echo "Building from $IMAGE_NAME"

COPY --from=builder /root/.m2 /opt/jboss/.m2

ENV KIE_SERVER_PROFILE standalone

ENV JAVA_OPTS -Xms256m -Xmx2048m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=512m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8 \
 -Dorg.uberfire.domain=other -Dorg.jbpm.ejb.timer.local.cache=false -Dorg.jbpm.ejb.timer.tx=true -Dorg.kie.controller.ping.alive.timeout=5000000

COPY etc/drivers /etc/drivers/
ADD etc/jbpm-custom.cli $JBOSS_HOME/bin/jbpm-custom.cli

USER root

RUN chmod +x $JBOSS_HOME/bin/jboss-cli.sh
RUN chown jboss:jboss $JBOSS_HOME/bin/jboss-cli.sh $JBOSS_HOME/bin/jbpm-custom.cli

USER jboss

RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/jbpm-custom.cli && \
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current

WORKDIR $JBOSS_HOME/bin/

CMD "sh" "-c" "./${START_SCRIPT}"