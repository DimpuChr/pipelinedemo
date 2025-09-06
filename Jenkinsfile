def IMAGE_TAG = ''
pipeline {
  #agent  { label 'docker-agent' }
  agent any

  environment {
          IMAGE_NAME = 'dimpuchr/my-app'   // Your Docker Hub repo name
          //IMAGE_TAG  = '${env.BUILD_NUMBER}-latest'
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
    stage('Set Image Tag') {
          steps {
            script {
              IMAGE_TAG = "${env.BUILD_NUMBER}-latest"
              echo "Using IMAGE_TAG = ${IMAGE_TAG}"
            }
          }
        }
    /* stage('SonarQube Analysis') {
        steps {
            withSonarQubeEnv('My SonarQube') {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    bat """
                        %SONAR_SCANNER_HOME%\\bin\\sonar-scanner.bat ^
                        -Dsonar.projectKey=my-app ^
                        -Dsonar.sources=. ^
                        -Dsonar.host.url=http://localhost:9000 ^
                        -Dsonar.login=%SONAR_TOKEN%
                    """
                }
            }
        }
    } */

   stage('Build Docker Image') {
       steps {
           echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
           bat """
               docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
           """
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

                echo "Pushing versioned image"
                bat "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
        }
       }
      }
    }

    stage('Checkout Manifests Repo') {
        steps {
            // This is your separate Git repo where deployment.yaml lives
            dir('manifests-repo') {
            git branch: 'develop', url: 'https://github.com/DimpuChr/templates_demo.git'
            }
        }
    }

    stage('Update Deployment Manifest') {
          steps {
            dir('manifests-repo') {
              script {
                echo "Updating image tag in deployment.yaml"

                // Update YAML image tag
                bat """
                powershell -Command "(Get-Content deployment.yaml) -replace 'image:\\s*${IMAGE_NAME}:.+', 'image: ${IMAGE_NAME}:${IMAGE_TAG}' | Set-Content deployment.yaml"
                """

                bat "type deployment.yaml"
                 // Commit & push change with credentials
                  withCredentials([usernamePassword(credentialsId: 'github-creds', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                                    bat """
                                      git config user.name "DimpuChr"
                                      git config user.email "bmdarshan.c@gmail.com"
                                      git add deployment.yaml
                                      git commit -m "Update image tag to ${IMAGE_TAG}" || echo "No changes to commit"
                                      git push https://${GIT_USER}:${GIT_PASS}@github.com/dimpuchr/templates_demo.git develop
                                    """
                  }
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
