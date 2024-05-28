pipeline {
    agent {
        docker {
            image 'dimpuchr/dimpu:dockerimage'
            args "-v \"C:/Program Files/Jenkins/workspace/pipelinedemo:/workspace/pipelinedemo\" -w \"/workspace/pipelinedemo\""
        }
    }
    stages {
        stage('Run Docker Container') {
            steps {
                script {
                    // Run commands inside the Docker container
                    sh 'mvn clean package'
                    // Additional commands can be added here
                }
            }
        }
    }
}
