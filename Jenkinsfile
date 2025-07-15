pipeline {
  agent {
      docker { image 'maven:3.8.5-openjdk-17' }
    }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/DimpuChr/pipelinedemo.git'
      }
    }

    stage('Build') {
      steps {
        bat 'mvn clean install'
      }
    }

    stage('Test') {
      steps {
        bat 'mvn test'
      }
    }
  }
}
