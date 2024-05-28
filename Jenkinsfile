pipeline {
    agent {
        docker {
            image 'dimpuchr/dimpu:dockerimage'
            args '-v "C:/Program Files/Jenkins/workspace/pipelinedemo:/workspace/pipelinedemo" -v "C:/Program Files/Jenkins/workspace/pipelinedemo@tmp:/workspace/pipelinedemo@tmp"'
        }
    }
    environment {
        WORKSPACE_PATH = '/workspace/pipelinedemo'
    }
    stages {
        stage('Run Docker Container') {
            steps {
                script {
                    // Ensure the working directory is properly set inside the Docker container
                    sh "echo 'Running inside Docker container at ${env.WORKSPACE_PATH}'"
                    // Additional commands can be added here
                }
            }
        }
    }
}
