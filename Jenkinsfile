pipeline {
  agent any
  stages {
    stage('BUILD - WSO2 Service') {
      steps {
        echo 'BUILD - WSO2 Service: started'
        sh '''cd wso2-services
mvn clean install'''
        echo 'BUILD - WSO2 Service: completed successfully'
      }
    }

    stage('BUILD - WSO2 Docker Image') {
      steps {
        echo 'BUILD - WSO2 Docker Image: started'
        sh '''cd wso2-docker-images
mvn clean install'''
        echo 'BUILD - WSO2 Docker Image: completed successfully'
      }
    }

    stage('TEST - WSO2 Docker Image') {
      steps {
        echo 'TEST - WSO2 Docker Image: started'
        sh './deployment-scripts/undeploy-docker-container.sh test'
        echo 'TEST - WSO2 Docker Image: test environment undeployed'
        sh './deployment-scripts/deploy-wso2-docker-image.sh test $WSO2_HTTP_PORT_TEST $WSO2_HTTPS_PORT_TEST $DOCKER_ORGANIZATION $DOCKER_REPOSITORY'
        echo 'TEST - WSO2 Docker Image: test environment deployment successful'
        sleep 30
        sh './deployment-scripts/execute-deployment-check.sh test $ASSERTIBLE_ACCESS_TOKEN $ASSERTIBLE_SERVICE_ID'
        echo 'TEST - WSO2 Docker Image: tests passed'
        echo 'TEST - WSO2 Docker Image: completed successfully'
      }
    }

    stage('WSO2 Docker Image Deploy') {
      steps {
        echo 'WSO2 Docker Image Deploy: started'
        sh 'docker rm -f $(docker ps -a -q)'
        echo 'WSO2 Docker Image Deploy: obsolete image removed'
        sh 'docker run -itd -p 8290:8290 -p 8253:8253 --name wso2-service rastylaurinc/wso2-images'
        echo 'WSO2 Docker Image Deploy: completed successfully'
      }
    }

  }
  environment {
    DOCKER_ORGANIZATION = 'rastylaurinc'
    DOCKER_REPOSITORY = 'wso2-images'
    WSO2_HTTP_PORT_TEST = '8289'
    WSO2_HTTP_PORT_PROD = '8290'
    WSO2_HTTPS_PORT_TEST = '8252'
    WSO2_HTTPS_PORT_PROD = '8253'
    ASSERTIBLE_ACCESS_TOKEN = 'MbbLai3DWIbBaIOo'
    ASSERTIBLE_SERVICE_ID = 'a819678d-02db-44a4-afca-5583a1084620'
  }
}