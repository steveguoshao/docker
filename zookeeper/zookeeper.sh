#!/bin/bash

source /etc/profile

ZK_HOME=/usr/local/zookeeper
ZK_SERVER_ID=$ZK_HOME/data/myid
ZK_CFG=$ZK_HOME/conf/zoo.cfg

#output server id
echo "SERVER_ID:${SERVER_ID}"
echo "${SERVER_ID}" > $ZK_SERVER_ID

#add zookeeper cluster servers into zoo.cfg file
for server in $ZK_SERVERS; do
    echo "$server" >> "$ZK_CFG"
done


#start zookeeper
sh /usr/local/zookeeper/bin/zkServer.sh start-foreground
