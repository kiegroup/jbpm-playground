jBPM Kie Server with MSSQL server
========================================================

This project is a springboot sample application that is based on jbpm-spring-boot-starter-basic 
and provides all the infrastructure needed to test jBPM springboot with MSSQL server as persistence database. 
It provides all services from jbpm-services-api that are directly available for injection/autowire.

Use following command to build the project and execute tests:

```
mvn clean install
```


MSSQL database version can be tuned by setting following property (default value is `mcr.microsoft.com/mssql/server:2019-latest`):

```
-Dorg.kie.samples.image.sqlserver
```

But notice that in SQLServer images 2016 and 2017 for Linux, it is not possible to use XA transactions.
Support for XA transactions was added to the MSSQL 2019 docker image.

