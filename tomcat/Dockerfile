FROM registry-internal.cn-hangzhou.aliyuncs.com/distributed/java:jdk8

MAINTAINER Steve Guo <steveguoshao@gmail.com>

RUN yum -y install wget \
    && wget --no-cookie --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" \
    -P /usr/local/src http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz \
    && mkdir /usr/local/tomcat \
    && tar --strip-components=1 -xzf /usr/local/src/apache-tomcat-8.5.20.tar.gz -C /usr/local/tomcat \
    && rm -rf /usr/local/tomcat/webapps/* \
    && mkdir /usr/local/tomcat/webapps/ROOT \
    && rm -rf /usr/local/src/* \
    && yum -y remove wget \
    && yum clean all

EXPOSE 8080

ADD server.xml /usr/local/tomcat/conf

ADD index.html /usr/local/tomcat/webapps/ROOT/

ADD tomcat.sh /root/tomcat.sh

RUN chmod u+x /root/tomcat.sh

CMD ["/root/tomcat.sh"]

