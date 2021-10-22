Deadline notifications after KIE server restart
===============================================

This project is used as a reproducer to validate fix provided by [JBPM-9920](https://issues.redhat.com/browse/JBPM-9920): duplicated emails were received in the target inboxes.

You can read about it in this blog post: https://blog.kie.org/2021/11/deadline-notifications-after-restart.html

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

This project is using only `kie-server-showcase` image but it is prepared for adding other images at any other profile (current default profile is *kie-server*).

