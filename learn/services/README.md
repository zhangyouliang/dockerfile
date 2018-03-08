> https://docs.docker.com/get-started/part3/#run-your-new-load-balanced-app


Run your new load-balanced app
====

````
## init swarm
docker swarm init 
## deploy app of docker-compose.yml
docker stack deplou -c docker-compose.yml getstartedlab
## get the service id fro the one service in our application
docker service ls
## list the tasks for our service
docker service ps getstartedlab_web
````
Scale the app
====

````
### update replicas to 3 from 5
docker stack deploy -c docker-compose.yml getstartedlb 
````

Task down the app and the swarm
====

- Take the app down with `docker stack rm`
````
docker stack rm getstartedlab
````
- Take down the swarm.
````
docker swarm leave --force
````


Some commands to explore at this stage:
````
docker stack ls                                            # List stacks or apps
docker stack deploy -c <composefile> <appname>  # Run the specified Compose file
docker service ls                 # List running services associated with an app
docker service ps <service>                  # List tasks associated with an app
docker inspect <task or container>                   # Inspect task or container
docker container ls -q                                      # List container IDs
docker stack rm <appname>                             # Tear down an application
docker swarm leave --force      # Take down a single node swarm from the manager
````







docker swarm 命令
====
### # docker stack

- deploy      Deploy a new stack or update an existing stack
- ls          List stacks
- ps          List the tasks in the stack
- rm          Remove one or more stacks
- services    List the services in the stack

### # docker service 

- create      Create a new service
- inspect     Display detailed information on one or more services
- logs        Fetch the logs of a service or task
- ls          List services
- ps          List the tasks of one or more services
- rm          Remove one or more services
- rollback    Revert changes to a service's configuration
- scale       Scale one or multiple replicated services
- update      Update a service

### # docker swarm
- ca          Display and rotate the root CA
- init        Initialize a swarm
- join        Join a swarm as a node and/or manager
- join-token  Manage join tokens
- leave       Leave the swarm
- unlock      Unlock swarm
- unlock-key  Manage the unlock key
- update      Update the swarm
