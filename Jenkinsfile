pipeline {
    agent {
        docker {
            image 'dimpuchr/dimpu/dockerimage'
        }
    }

    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/your-image-name'
        KUBE_NAMESPACE = 'default'
        KUBE_DEPLOYMENT_NAME = 'springboot-app'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/springboot-app.git'
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

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh "kubectl apply -f deployment.yaml -n ${env.KUBE_NAMESPACE}"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
