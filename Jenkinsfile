pipeline {
  agent any

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
