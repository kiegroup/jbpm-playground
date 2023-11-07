LDAP Concurrency tests
===============================================

This project is used as a reproducer to validate fix provided by [JBPM-10051](https://issues.redhat.com/browse/JBPM-10051): Task operations fail intermittently when using LDAPUserGroupCallback.
It executes 50 concurrent attempts to start a task using LDAP authentication.

**If you want to know more details about LDAP configuration and the KJAR used in this project, [read this article at KIE blog](https://blog.kie.org/2021/02/migrating-jbpm-images-secured-by-ldap-to-elytron.html).**

## Building

For building this project locally, you firstly need to have the following tools installed locally:
- git client
- Java 1.8
- Maven
- docker (because of testcontainers makes use of it).

Once you clone the repository locally all you need to do is to execute the following Maven build:

```
mvn clean install
```

for the `kie-server-showcase` scenarios (-Pkie-server, activated by default).

For exercising `jbpm-server-full` image, use full profile:

```
mvn clean install -Pfull
```

Other options are:

Property      | Function
------------- | ----------------------------------------------
ldapLog       | Prints out LDAP image logs


Example:

```
mvn clean install -Pfull -DldapLog
```
