# Multi-stage Dockerfile

# First, build kjar from a maven image

ARG IMAGE_NAME
ARG KJAR_VERSION

FROM openjdk:18-ea-11-alpine AS builder
ARG KJAR_VERSION
RUN apk add maven
LABEL autodelete="true"
COPY etc/kjars/ /etc/kjars/

RUN echo "Using pom with kjar version:: $KJAR_VERSION"
RUN mvn --file "/etc/kjars/evaluation/pom-$KJAR_VERSION.xml" --batch-mode install -DskipTests

#########################################################
# Dockerfile that provides the image for KIE Server
#########################################################

FROM $IMAGE_NAME

RUN echo "Building from $IMAGE_NAME"


COPY --from=builder /root/.m2 /opt/jboss/.m2
ENV KIE_SERVER_PROFILE standalone

COPY etc/drivers /etc/drivers/
ADD etc/jbpm-custom.cli $JBOSS_HOME/bin/jbpm-custom.cli
ADD etc/serverks.pkcs12 $JBOSS_HOME/standalone/configuration/serverks.pkcs12

USER root

RUN chmod +x $JBOSS_HOME/bin/jboss-cli.sh
RUN chown jboss:jboss $JBOSS_HOME/bin/jboss-cli.sh $JBOSS_HOME/bin/jbpm-custom.cli $JBOSS_HOME/standalone/configuration/serverks.pkcs12
RUN chown -R jboss:jboss /opt/jboss/.m2

USER jboss

RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/jbpm-custom.cli && \
rm -rf $JBOSS_HOME/standalone/configuration/standalone_xml_history/current

WORKDIR $JBOSS_HOME/bin/

CMD "sh" "-c" "./${START_SCRIPT}"