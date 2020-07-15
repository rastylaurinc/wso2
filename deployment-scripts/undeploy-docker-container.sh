#!/bin/sh

# log: start
echo 'undeploy-docker-container.sh: started'

DOCKER_SERVICE=wso2-$1-service
echo 'undeploy-docker-container.sh: undeploying docker service '\'$DOCKER_SERVICE\'

# get container id 
DOCKER_SERVICE_ID=`docker ps -a | grep $DOCKER_SERVICE | cut -d ' ' -f1`
echo 'id: '$DOCKER_SERVICE_ID

# remove docker container
if [ -z $DOCKER_SERVICE_ID ]; then
    echo 'undeploy-docker-container.sh: container not found'
  else
    docker stop $DOCKER_SERVICE_ID
    echo 'undeploy-docker-container.sh: container '\'$DOCKER_SERVICE\'' stopped'
    docker rm $DOCKER_SERVICE_ID
    echo 'undeploy-docker-container.sh: container '\'$DOCKER_SERVICE\'' removed'
fi

# log: successful finish
echo 'undeploy-docker-container.sh: completed successfully' 
