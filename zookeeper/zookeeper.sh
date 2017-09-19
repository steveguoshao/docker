#!/bin/bash

source /etc/profile

ZK_HOME=/usr/local/zookeeper
ZK_CFG=$ZK_HOME/conf/zoo.cfg

#output myid
echo "myid:${MY_ID}"
echo "${MY_ID}" > $ZK_HOME/data/myid

#add zookeeper cluster servers into zoo.cfg file
for server in $ZK_SERVERS; do
    echo "$server" >> "$ZK_CFG"
done


#start zookeeper
sh /usr/local/zookeeper/bin/zkServer.sh start-foreground
