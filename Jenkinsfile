pipeline {
  agent any

  environment {
          IMAGE_NAME = 'dimpuchr/my-app'   // Your Docker Hub repo name
          IMAGE_TAG = 'latest'             // You can change this to a dynamic tag later
      }


  stages {
    stage('Checkout') {
      steps {
        echo("checking out from scm")
        git url: 'https://github.com/DimpuChr/pipelinedemo.git'
      }
    }

    stage('Build') {
      steps {
        echo("building")
        bat 'mvn clean install'
      }
    }

    stage('Test') {
      steps {
        bat 'mvn test'
      }
    }
    stage('Build Docker Image') {
       steps {
           script {
               echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
               docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
           }
       }
    }
    stage('Push to Docker Hub') {
        steps {
           withCredentials([usernamePassword(
               credentialsId: 'dockerhub-cred',
               usernameVariable: 'DOCKER_USER',
               passwordVariable: 'DOCKER_PASS'
            )]) {
            script {
                echo "Logging into Docker Hub as ${DOCKER_USER}"
                bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"

                echo "Pushing image to Docker Hub"
                bat "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
        }
       }
      }
    }

  }
  post {
          always {
              echo "Pipeline finished"
              //started git changes
          }
      }
}
