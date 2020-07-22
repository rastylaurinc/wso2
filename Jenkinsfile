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

    stage('DEPLOY - WSO2 Docker Image') {
      steps {
        echo 'DEPLOY - WSO2 Docker Image: started'
        sh './deployment-scripts/undeploy-docker-container.sh production'
        echo 'DEPLOY - WSO2 Docker Image: production environment undeployed'
        sh './deployment-scripts/deploy-wso2-docker-image.sh production $WSO2_HTTP_PORT_PROD $WSO2_HTTPS_PORT_PROD $DOCKER_ORGANIZATION $DOCKER_REPOSITORY'
        echo 'DEPLOY - WSO2 Docker Image: completed successfully'
        sleep 30
        sh './deployment-scripts/execute-deployment-check.sh production $ASSERTIBLE_ACCESS_TOKEN $ASSERTIBLE_SERVICE_ID'
        echo 'DEPLOY - WSO2 Docker Image: production tests passed'
        echo 'DEPLOY - WSO2 Docker Image: production environment deployment successful'
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
