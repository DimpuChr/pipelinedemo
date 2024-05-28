pipeline {
    agent {
        docker {
            image 'dimpuchr/dimpu:dockerimage'
            args '-v "C:/Program Files/Jenkins/workspace/pipelinedemo:C:/Program Files/Jenkins/workspace/pipelinedemo" -v "C:/Program Files/Jenkins/workspace/pipelinedemo@tmp:C:/Program Files/Jenkins/workspace/pipelinedemo@tmp"'
        }
    }
    environment {
        WORKSPACE_PATH = 'C:/Program Files/Jenkins/workspace/pipelinedemo'
    }
    stages {
        stage('Run Docker Container') {
            steps {
                script {
                    // Run commands inside the Docker container
                    sh 'echo "Running inside Docker container"'
                    // Additional commands can be added here
                }
            }
        }
    }
}
