Transactional EJB Timers (persisted with postgresql) in jBPM
========================================================

This project is used as a reproducer to validate fix provided by [jbpm#1926](https://github.com/kiegroup/jbpm/pull/1926)

## Building

For building this project locally, you firstly need to have the following tools installed locally:
- git client
- Java 1.8
- Maven
- docker (because of testcontainers makes use of it).

Once you cloned the repository locally all you need to do is execute the following Maven build:

```
mvn clean install
```

Following properties at the pom may be tuned:
```
<org.jbpm.ejb.timer.local.cache>false</org.jbpm.ejb.timer.local.cache>
<org.jbpm.ejb.timer.tx>true</org.jbpm.ejb.timer.tx>
```


