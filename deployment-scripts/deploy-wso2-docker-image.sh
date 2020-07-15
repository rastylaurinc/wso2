#!/bin/sh

# log: start
echo 'deploy-wso2-docker-image.sh: started'

# retrieve variables from the input
WSO2_ENV=$1
WSO2_HTTP_PORT=$2
WSO2_HTTPS_PORT=$3
DOCKER_ORG=$4
DOCKER_REPO=$5

# deploy docker image
echo 'deploy-wso2-docker-image.sh: starting docker service '\''wso2-'$WSO2_ENV'-service'\'
docker run -itd -p $WSO2_HTTP_PORT:8290 -p $WSO2_HTTPS_PORT:8253 --name wso2-${WSO2_ENV}-service ${DOCKER_ORG}/${DOCKER_REPO}
if [ $? -eq 0 ]; then
    echo 'deploy-wso2-docker-image.sh: docker service '\''wso2-'$WSO2_ENV'-service'\'' started successfully'
  else
    echo 'deploy-wso2-docker-image.sh: docker service '\''wso2-'$WSO2_ENV'-service'\'' deployment failed'
    exit $?
fi	  

# log: successful finish
echo 'deploy-wso2-docker-image.sh: completed successfully'
