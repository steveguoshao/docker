FROM registry-internal.cn-hangzhou.aliyuncs.com/distributed/java:jdk8

MAINTAINER Steve Guo <steveguoshao@gmail.com>

RUN yum -y install wget \
    && wget --no-cookie --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" \
    -P /usr/local/src https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz \
    && mkdir /usr/local/zookeeper \
    && tar --strip-components=1 -xzf /usr/local/src/zookeeper-3.4.10.tar.gz -C /usr/local/zookeeper \
    && mkdir /usr/local/zookeeper/data \
    && touch /usr/local/zookeeper/data/myid \
    && mkdir /usr/local/zookeeper/logs \
    && rm -rf /usr/local/src/* \
    && yum -y remove wget \
    && yum clean all

EXPOSE 2181 2888 3888

ADD zoo.cfg /usr/local/zookeeper/conf/zoo.cfg

ADD zookeeper.sh /root/zookeeper.sh

RUN chmod u+x /root/zookeeper.sh

CMD ["/root/zookeeper.sh"]

