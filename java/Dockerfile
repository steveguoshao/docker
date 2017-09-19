
FROM centos:latest

MAINTAINER Steve Guo <steveguoshao@gmail.com>

RUN yum -y install wget \
    && wget --no-cookie --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" \
    -P /usr/local/src http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz \
    && mkdir /usr/local/java \
    && tar -xzvf /usr/local/src/jdk-8u144-linux-x64.tar.gz -C /usr/local/java \
    && rm -rf /usr/local/src/* \
    && yum -y remove wget \
    && yum clean all

ENV JAVA_HOME=/usr/local/java/jdk1.8.0_144
ENV PATH=$JAVA_HOME/bin:$PATH
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/tools.jar