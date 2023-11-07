Timer migration from jBPM 6.x (persisted with mysql)
=====================================================

This project is used as a reproducer to validate fix provided by [jbpm#2149](https://github.com/kiegroup/jbpm/pull/2149) 

Non-existing [SLA]... timer with session id=0 shown when using REST API to list all available timers in migrated process instance

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

Other options are:

Property      | Function
------------- | ----------------------------------------------
noPatch       | If present, skip the installation of the patch


Example:

```
mvn clean install -Pfull -DnoPatch
```

Notice that for current version (7.69.0.Final) tests will fail if patch is not installed.
