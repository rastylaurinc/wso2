pipeline {
  agent any
  stages {
    stage('WSO2 Service Build') {
      steps {
        echo 'WSO2 Service Build started'
        sh '''cd wso2-services
mvn clean install'''
        echo 'WSO2 Service Build completed successfully'
      }
    }

    stage('WSO2 Docker Image Build') {
      steps {
        echo 'WSO2 Docker Image Build started'
        sh '''pwd
cd wso2-docker-images'''
        echo 'WSO2 Docker Image Build completed successfully'
      }
    }

  }
}