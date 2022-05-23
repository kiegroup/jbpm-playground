Smart Router Network Issues
========================================================

This project is explained in this blog entry (https://blog.kie.org/2022/03/smart-router.html)

## Building

For building this project locally, you firstly need to have the following tools installed locally:
- git client
- Java 1.8
- Maven
- docker (because of testcontainers makes use of it).

Once you have cloned the repository locally all you need to do is to execute the following Maven build:

```
mvn clean install
```

Other options are:

Property      | Function
------------- | --------------------------------------------------------------
allToxics     | If present, exercise all the combinations for different toxics


Example:

```
mvn clean install -DallToxics
```
