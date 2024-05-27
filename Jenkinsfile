pipeline {
    agent {
        docker {
            image 'dimpuchr/dimpu:dockerimage'
        }
    }

    environment {
        DOCKER_IMAGE = 'dimpuchr/pipeline-demo'
        KUBE_NAMESPACE = 'default'
        KUBE_DEPLOYMENT_NAME = 'pipeline-demo'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/DimpuChr/pipelinedemo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build("${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}", ".")
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Verify kubectl context') {
            steps {
                sh 'kubectl config current-context'
                sh 'kubectl cluster-info'
            }
        }

        stage('Deploy to Minikube') {
            steps {
                withCredentials([file(credentialsId: 'minikube-kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f deployment.yml'
                }
            }
        }

    }

}
