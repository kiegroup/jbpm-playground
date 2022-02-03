Unmarshall EJB Timers (persisted with postgresql) in multinode jBPM
===================================================================

This project is used as a reproducer to validate fix provided by [JBPM-9912](https://issues.redhat.com/browse/JBPM-9912) with KIE server multinode setups. The following sequence of actions can lead to duplicate EJB timer instances getting created:

1. Start a process instance containing a timer on node1
2. Access the newly created process instance on node2 (eg. REST call to retrieve variables)

If the call in step #2 happens before the EJB timers are synced at the EAP layer (wait time < refresh-interval), then jbpm will create a second EJB timer instance during the session initialization.

This project exercises test for that scenario. It takes advantage of [testcontainers](https://www.testcontainers.org) library, creating images on-the-fly, from the multistage Dockerfile that it's used to:
- build the kjar project
- patch the image with the fixed classes at the corresponding jar
- invoke a custom cli scripts to configure postgresql persistence and the clustered EJB timers support


## Building

For building this project locally, you firstly need to have the following tools installed locally:
- git client
- Java 1.8
- Maven
- docker (because of testcontainers makes use of it).

Once you clone the repository locally all you need to do is to execute the following Maven build (for cluster scenarios):

```
mvn clean install
```

Notice that property `org.jbpm.timer.disableUnmarshallerRegistration` is set to true for the scenario to work.

This project is using only `kie-server-showcase` image but it is prepared for adding other images at any other profile (current default profile is *kie-server*).


