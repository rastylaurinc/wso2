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
        echo 'WSO2 Docker Image Test: completed successfully'
      }
    }

    stage('WSO2 Docker Image Deploy') {
      steps {
        echo 'WSO2 Docker Image Deploy: started'
        sh 'docker rm -f $(docker ps -a -q)'
        echo 'WSO2 Docker Image Deploy: obsolete image removed'
        sh 'docker run -itd -p 8290:8290 -p 8253:8253 --name wso2-service rastylaurinc/training-repo'
        echo 'WSO2 Docker Image Deploy: completed successfully'
      }
    }

  }
}