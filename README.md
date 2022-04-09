# Configuration Server

Configuration server for Spring applications using Spring Data JDB, Spring Cloud Config Server and Microsoft SQL Server
Database.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing
purposes. See deployment for notes on how to deploy the project on a live system.

### Environment Variables

To run this project, you will need to add the following environment variables on your system.

* `APP_DATABASE_SELECTOR`
* `APP_DATABASE_HOST`
* `APP_DATABASE_PORT`
* `APP_DATABASE_NAME`
* `APP_DATABASE_USERNAME`
* `APP_DATABASE_PASSWORD`
* `APP_DATABASE_QUERY`

### Installing

* Clone or download project.
* Import the project into the IDE of your choice.
* Run the ``mvn clean`` and ``mvn install`` commands in the IDE to have maven handle the necessary dependencies and
  generate the project executable.
* Run the project to validate that everything works correctly.

## Built With

* [Maven](https://maven.apache.org/) - Dependency Management
* [Spring](https://spring.io/) - Java Framework

### Reference Documentation

For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.6.4/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/2.6.4/maven-plugin/reference/html/#build-image)
* [Config Server](https://docs.spring.io/spring-cloud-config/docs/current/reference/html/#_spring_cloud_config_server)
* [Spring Data JDBC](https://docs.spring.io/spring-boot/docs/2.6.4/reference/htmlsingle/#features.sql.jdbc)

### Guides

The following guides illustrate how to use some features concretely:

* [Centralized Configuration](https://spring.io/guides/gs/centralized-configuration/)
* [Using Spring Data JDBC](https://github.com/spring-projects/spring-data-examples/tree/master/jdbc/basics)

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see
the [tags on this repository](https://github.com/DanielPrz1394/configuration-server/tags).

## Authors

- **[DanielPrz1394](https://github.com/DanielPrz1394)** - *Initial work*

## License

This project is licensed under ***The Apache License, Version 2.0*** - see the [LICENSE](LICENSE) file for details.