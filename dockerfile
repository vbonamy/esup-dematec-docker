FROM debian:stretch

MAINTAINER EsupPortail - Vincent Bonamy

ENV PATH=$PATH:$JRE_HOME/bin

RUN apt-get update && apt-get install -y wget tar unzip git openjdk-8-jdk maven

RUN cd /opt/ && git clone https://github.com/EsupPortail/esup-dematec.git && cd esup-dematec && git checkout -b esup-dematec-prod EsupDematEC-1.5.5 
RUN sed -i 's/localhost/database/' /opt/esup-dematec/src/main/resources/META-INF/spring/database.properties
RUN cd /opt/esup-dematec && mvn clean package

CMD cd /opt/esup-dematec && mvn	jetty:run
