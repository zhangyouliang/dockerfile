> https://docs.docker.com/get-started/part4/#deploy-your-app-on-the-swarm-cluster

> 这里没有使用 docker-machine ,原因是我在 Ubuntu 16.04 服务器上面迟迟没响应

### docker swarm 


- 118.31.78.77      Leader
- 123.206.122.118   Worker

**118.31.78.77**
````
➜  ~ docker swarm init --advertise-addr=118.31.78.77
Swarm initialized: current node (8zcir2bt628hxz2zhcx7f70og) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-2055chnm9be77eor6ldwtyispg5unzmi9kqekx8murgtmvjbma-6elvy4hynxifo2utt5i2d3cem 118.31.78.77:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.



````

**123.206.122.118**
````
➜  ~ docker swarm join --token SWMTKN-1-2055chnm9be77eor6ldwtyispg5unzmi9kqekx8murgtmvjbma-6elvy4hynxifo2utt5i2d3cem 118.31.78.77:2377
This node joined a swarm as a worker.
````

然后查看 Leader

````
➜  ~ docker node ls                               
ID                            HOSTNAME                  STATUS              AVAILABILITY        MANAGER STATUS
8zcir2bt628hxz2zhcx7f70og *   iZbp1irx58yxevjbcslavlZ   Ready               Active              Leader
i3jpuhmf4mz5ra24l9wct33fi     krdevdb                   Ready               Active              
````


