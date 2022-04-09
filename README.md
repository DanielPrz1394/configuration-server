# Configuration Server

Configuration server for Spring applications using Spring Data JDB, Spring Cloud Config Server and Microsoft SQL Server
Database.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing
purposes.

### Prerequisites

* Microsoft SQL Server Database.
* Maven.
* Java JDK8.
* IDE of your choice.

### Environment Variables

To run this project, you will need to add the following environment variables on your system.

* `APP_DATABASE_SELECTOR`
* `APP_DATABASE_HOST`
* `APP_DATABASE_PORT`
* `APP_DATABASE_NAME`
* `APP_DATABASE_USERNAME`
* `APP_DATABASE_PASSWORD`
* `APP_DATABASE_QUERY`

### Database tables

#### Table of labels.

~~~~tsql
CREATE TABLE APPLICATION_LABELS
(
    LABEL_ID      SMALLINT     NOT NULL,
    LABEL_NAME    VARCHAR(255) NOT NULL,
    REGISTER_DATE DATETIME     NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT APPLICATION_LABELS_PK PRIMARY KEY NONCLUSTERED (LABEL_ID)
) WITH (DATA_COMPRESSION = PAGE);
GO

CREATE UNIQUE INDEX APPLICATION_LABELS_UINDEX1 ON APPLICATION_LABELS (LABEL_ID) WITH (DATA_COMPRESSION = PAGE);
CREATE UNIQUE INDEX APPLICATION_LABELS_UINDEX2 ON APPLICATION_LABELS (LABEL_NAME) WITH (DATA_COMPRESSION = PAGE);
GO
~~~~

##### Example

~~~~tsql
INSERT INTO APPLICATION_LABELS (LABEL_ID, LABEL_NAME)
VALUES (0, 'default');
GO
~~~~

#### Table of profiles

~~~~tsql
CREATE TABLE APPLICATION_PROFILES
(
    PROFILE_ID    SMALLINT     NOT NULL,
    PROFILE_NAME  VARCHAR(255) NOT NULL,
    REGISTER_DATE DATETIME     NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT APPLICATION_PROFILES_PK PRIMARY KEY NONCLUSTERED (PROFILE_ID)
) WITH (DATA_COMPRESSION = PAGE);
GO

CREATE UNIQUE INDEX APPLICATION_PROFILES_UINDEX1 ON APPLICATION_PROFILES (PROFILE_ID) WITH (DATA_COMPRESSION = PAGE);
CREATE UNIQUE INDEX APPLICATION_PROFILES_UINDEX2 ON APPLICATION_PROFILES (PROFILE_NAME) WITH (DATA_COMPRESSION = PAGE);
GO
~~~~

##### Example

~~~~tsql
INSERT INTO APPLICATION_PROFILES (PROFILE_ID, PROFILE_NAME)
VALUES (0, 'development'),
       (1, 'production');
GO
~~~~

#### Table of applications

~~~~tsql
CREATE TABLE APPLICATIONS
(
    APPLICATION_ID   UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    APPLICATION_NAME VARCHAR(255)     NOT NULL,
    APPLICATION_DESC VARCHAR(500)     NOT NULL,
    REGISTER_DATE    DATETIME         NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT APPLICATIONS_PK PRIMARY KEY NONCLUSTERED (APPLICATION_ID)
) WITH (DATA_COMPRESSION = PAGE);
GO

CREATE UNIQUE INDEX APPLICATIONS_UINDEX1 ON APPLICATIONS (APPLICATION_ID) WITH (DATA_COMPRESSION = PAGE);
CREATE UNIQUE INDEX APPLICATIONS_UINDEX2 ON APPLICATIONS (APPLICATION_NAME) WITH (DATA_COMPRESSION = PAGE);
GO
~~~~

##### Example

~~~~tsql
INSERT INTO APPLICATIONS (APPLICATION_ID, APPLICATION_NAME, APPLICATION_DESC)
VALUES (N'60CE8448-1F23-4185-ADB5-15ECD71E771E',
        N'eureka-server',
        N'Eureka server for microservices.');
~~~~

#### Table of properties

~~~~tsql
CREATE TABLE APPLICATION_PROPERTIES
(
    PROPERTY_ID   BIGINT                         NOT NULL,
    PROPERTY_KEY  VARCHAR(255)                   NOT NULL,
    PROPERTY_VAL  VARCHAR(255)                   NOT NULL,
    PROPERTY_DES  VARCHAR(500)                   NOT NULL,
    REGISTER_DATE DATETIME DEFAULT SYSDATETIME() NOT NULL,
    CONSTRAINT APPLICATION_PROPERTIES_PK PRIMARY KEY NONCLUSTERED (PROPERTY_ID)
) WITH (DATA_COMPRESSION = PAGE);
GO

CREATE UNIQUE INDEX APPLICATION_PROPERTIES_UINDEX1 ON APPLICATION_PROPERTIES (PROPERTY_ID, PROPERTY_KEY, PROPERTY_VAL) WITH (DATA_COMPRESSION = PAGE);
GO
~~~~

##### Example

~~~~tsql
INSERT INTO APPLICATION_PROPERTIES (PROPERTY_ID, PROPERTY_KEY, PROPERTY_VAL, PROPERTY_DES)
VALUES (1, N'server.port', N'8761', N'ESA - Eureka Server Property');
GO
~~~~

#### Table of configurations

~~~~tsql
CREATE TABLE APPLICATION_CONFIGURATIONS
(
    CONFIGURATION_ID BIGINT                         NOT NULL,
    APPLICATION_ID   UNIQUEIDENTIFIER               NOT NULL,
    PROPERTY_ID      BIGINT                         NOT NULL,
    PROFILE_ID       SMALLINT                       NOT NULL,
    LABEL_ID         SMALLINT                       NOT NULL,
    REGISTER_DATE    DATETIME DEFAULT SYSDATETIME() NOT NULL,
    CONSTRAINT APPLICATION_CONFIGURATIONS_PK PRIMARY KEY NONCLUSTERED (CONFIGURATION_ID),
    CONSTRAINT APPLICATION_CONFIGURATIONS_FK1 FOREIGN KEY (APPLICATION_ID) REFERENCES APPLICATIONS (APPLICATION_ID),
    CONSTRAINT APPLICATION_CONFIGURATIONS_FK2 FOREIGN KEY (PROPERTY_ID) REFERENCES APPLICATION_PROPERTIES (PROPERTY_ID),
    CONSTRAINT APPLICATION_CONFIGURATIONS_FK3 FOREIGN KEY (PROFILE_ID) REFERENCES APPLICATION_PROFILES (PROFILE_ID),
    CONSTRAINT APPLICATION_CONFIGURATIONS_FK4 FOREIGN KEY (LABEL_ID) REFERENCES APPLICATION_LABELS (LABEL_ID)
) WITH (DATA_COMPRESSION = PAGE);
GO

CREATE UNIQUE INDEX APPLICATION_CONFIGURATIONS_UINDEX1 ON APPLICATION_CONFIGURATIONS (CONFIGURATION_ID) WITH (DATA_COMPRESSION = PAGE);
GO
~~~~

##### Example

~~~~tsql
INSERT INTO APPLICATION_CONFIGURATIONS (CONFIGURATION_ID, APPLICATION_ID, PROPERTY_ID, PROFILE_ID, LABEL_ID)
VALUES (1, N'60CE8448-1F23-4185-ADB5-15ECD71E771E', 1, 0, 0);
~~~~

#### Configuration query

~~~~tsql
SELECT A.PROPERTY_KEY,
       A.PROPERTY_VAL
FROM APPLICATION_CONFIGURATIONS AC WITH (NOLOCK)
         INNER JOIN APPLICATION_LABELS AL WITH (NOLOCK) on AL.LABEL_ID = AC.LABEL_ID
         INNER JOIN APPLICATION_PROFILES AP WITH (NOLOCK) on AP.PROFILE_ID = AC.PROFILE_ID
         INNER JOIN APPLICATION_PROPERTIES A WITH (NOLOCK) on A.PROPERTY_ID = AC.PROPERTY_ID
         INNER JOIN APPLICATIONS A2 WITH (NOLOCK) on A2.APPLICATION_ID = AC.APPLICATION_ID
WHERE A2.APPLICATION_NAME = ?
  AND AP.PROFILE_NAME = ?
  AND AL.LABEL_NAME = ?
~~~~

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