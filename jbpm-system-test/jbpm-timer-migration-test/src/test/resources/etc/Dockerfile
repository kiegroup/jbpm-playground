# Multi-stage Dockerfile

# First, build kjar from a maven image

ARG IMAGE_NAME
ARG NO_PATCH

FROM maven:3.6.3-openjdk-8-slim as builder
ARG NO_PATCH
LABEL autodelete="true"
COPY etc/kjars/ /etc/kjars/
RUN mvn --file /etc/kjars/timer-sample/pom.xml --batch-mode install -DskipTests

#########################################################
# Dockerfile that provides the image for KIE Server
#########################################################

FROM $IMAGE_NAME
ARG NO_PATCH

RUN echo "Building from $IMAGE_NAME"

COPY --from=builder /root/.m2 /opt/jboss/.m2

ENV KIE_SERVER_PROFILE standalone

COPY etc/drivers /etc/drivers/
ADD etc/jbpm-custom.cli $JBOSS_HOME/bin/jbpm-custom.cli

ADD etc/jbpm-flow-7.69.0.Final.jar /WEB-INF/lib/jbpm-flow-7.69.0.Final.jar

RUN if [ -z "$NO_PATCH" ]; then \
rm $JBOSS_HOME/standalone/deployments/kie-server.war/WEB-INF/lib/jbpm-flow-7.69.0.Final.jar; \
cp /WEB-INF/lib/jbpm-flow-7.69.0.Final.jar $JBOSS_HOME/standalone/deployments/kie-server.war/WEB-INF/lib/jbpm-flow-7.69.0.Final.jar; \
fi

USER root

RUN chmod +x $JBOSS_HOME/bin/jboss-cli.sh
RUN chown jboss:jboss $JBOSS_HOME/bin/jboss-cli.sh $JBOSS_HOME/bin/jbpm-custom.cli

USER jboss

RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/jbpm-custom.cli && \
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current

WORKDIR $JBOSS_HOME/bin/

CMD "sh" "-c" "./${START_SCRIPT}"