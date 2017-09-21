# zookeeper镜像的基本使用
## 启动zookeeper镜像

    docker run --name my_zookeeper -d registry-internal.cn-hangzhou.aliyuncs.com/distributed/zookeeper:3.4.10
这个命令会在后台运行一个 zookeeper 容器, 名字是 my_zookeeper, 并且它默认会导出 2181 端口.

    docker logs -f my_zookeeper
这个命令查看 zookeeper 的运行情况

    docker logs -f my_zookeeper
使用 zookeeper 命令行客户端连接 zookeeper 因为刚才我们启动的那个 zookeeper 容器并没有绑定宿主机的端口, 因此我们不能直接访问它. 
但是我们可以通过 Docker 的 link 机制来对这个 ZK 容器进行访问. 执行如下命令

    docker run -it --rm --link my_zookeeper:zookeeper zookeeper zkCli.sh -server zookeeper
这个命令的含义是:
   启动一个 zookeeper 镜像, 并运行这个镜像内的 zkCli.sh 命令, 命令参数是 "-server zookeeper"
将我们先前启动的名为 my_zookeeper 的容器连接(link) 到我们新建的这个容器上, 并将其主机名命名为 zookeeper
当我们执行了这个命令后, 就可以像正常使用 ZK 命令行客户端一样操作 zookeeper 服务了.

# 通过 docker-compose 在一台机器上启动 zookeeper 集群的
docker-compose.yml文件：

    version: '2'
    services:
        zookeeper1:
            image: registry-internal.cn-hangzhou.aliyuncs.com/distributed/zookeeper:3.4.10
            restart: always
            container_name: zookeeper1
            ports:
                - "2181:2181"
            environment:
                SERVER_ID: 1
                ZK_SERVERS: server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888
        zookeeper2:
            image: registry-internal.cn-hangzhou.aliyuncs.com/distributed/zookeeper:3.4.10
            restart: always
            container_name: zookeeper2
            ports:
                - "2182:2181"
            environment:
                SERVER_ID: 2
                ZK_SERVERS: server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888
        zookeeper3:
            image: registry-internal.cn-hangzhou.aliyuncs.com/distributed/zookeeper:3.4.10
            restart: always
            container_name: zookeeper3
            ports:
                - "2183:2181"
            environment:
                SERVER_ID: 3
                ZK_SERVERS: server.1=zookeeper1:2888:3888 server.2=zookeeper2:2888:3888 server.3=zookeeper3:2888:3888

## 启动zookeeper集群命令
    COMPOSE_PROJECT_NAME=zookeeper_cluster docker-compose up -d
## 查看zookeeper集群状态
    COMPOSE_PROJECT_NAME=zookeeper_cluster docker-compose ps
## 查看zookeeper集群日志
    COMPOSE_PROJECT_NAME=zookeeper_cluster docker-compose logs

## 查看zookeeper各节点状态
    echo stat | nc 127.0.0.1 2181

    echo stat | nc 127.0.0.1 2182

    echo stat | nc 127.0.0.1 2183

## 使用Docker命令行客户端连接 zookeeper 集群
    docker run -it --rm \
        --link zookeeper1:zookeeper1 \
        --link zookeeper2:zookeeper2 \
        --link zookeeper3:zookeeper3 \
        --net zookeeper_cluster_default \
        zookeeper zkCli.sh -server zookeeper1:2181,zookeeper2:2181,zookeeper3:2181
        
## 通过本地主机连接zookeeper集群
    ./bin/zkCli.sh -server localhost:2181,localhost:2182,localhost:2183

