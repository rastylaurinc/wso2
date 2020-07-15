pipeline {
  agent any
  stages {
    stage('WSO2 Service Build') {
      steps {
        echo 'WSO2 Service Build: started'
        sh '''cd wso2-services
mvn clean install'''
        echo 'WSO2 Service Build: completed successfully'
      }
    }

    stage('WSO2 Docker Image Build') {
      steps {
        echo 'WSO2 Docker Image Build: started'
        sh '''cd wso2-docker-images
mvn clean install'''
        echo 'WSO2 Docker Image Build: completed successfully'
      }
    }

    stage('WSO2 Docker Image Test') {
      steps {
        echo 'WSO2 Docker Image Test: started'
        sh './deployment-scripts/execute-deployment-check.sh $ASSERTIBLE_ACCESS_TOKEN $ASSERTIBLE_SERVICE_ID test'
        echo 'WSO2 Docker Image Test: completed successfully'
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