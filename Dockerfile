FROM openjdk:8-jdk-alpine

RUN apk add tzdata
RUN cp /usr/share/zoneinfo/America/Mexico_City /etc/localtime
RUN echo "America/Mexico_City" > /etc/timezone
RUN apk del tzdata

ENV APP_DATABASE_QUERY="SELECT A.PROPERTY_KEY, A.PROPERTY_VAL FROM APPLICATION_CONFIGURATIONS AC WITH (NOLOCK) INNER JOIN APPLICATION_LABELS AL WITH (NOLOCK) on AL.LABEL_ID = AC.LABEL_ID INNER JOIN APPLICATION_PROFILES AP WITH (NOLOCK) on AP.PROFILE_ID = AC.PROFILE_ID INNER JOIN APPLICATION_PROPERTIES A WITH (NOLOCK) on A.PROPERTY_ID = AC.PROPERTY_ID INNER JOIN APPLICATIONS A2 WITH (NOLOCK) on A2.APPLICATION_ID = AC.APPLICATION_ID WHERE A2.APPLICATION_NAME = ? AND AP.PROFILE_NAME = ? AND AL.LABEL_NAME = ?"
ENV APP_DATABASE_SELECTOR="sqlserver"
ENV APP_DATABASE_HOST=""
ENV APP_DATABASE_PORT=""
ENV APP_DATABASE_NAME=""
ENV APP_DATABASE_USERNAME=""
ENV APP_DATABASE_PASSWORD=""

COPY ./target/configuration-server.jar /home/configuration-server.jar
EXPOSE 8888
ENTRYPOINT ["java", "-jar","-Xms100M","-Xmx100M", "/home/configuration-server.jar"]
