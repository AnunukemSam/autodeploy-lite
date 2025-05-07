pipeline {
    agent any

     environment {
        IMAGE_NAME = "anunukemsam/flaskapp"
        TAG = "${BUILD_NUMBER}"
    }
    stages {
        stage("Build") {
            steps {
                echo "Building docker image..."
                script {
                    image = docker.build("${IMAGE_NAME}:${TAG}", "apps/flaskapp")
                }
            }
        }
        stage("Test") {
            steps {
                echo "Scanning docker image ..."
                withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
                    sh '''
                        snyk auth $SNYK_TOKEN
                        snyk container test ${IMAGE_NAME}:${TAG} || true
                    '''
                }
            }
        }
        stage("Login to DockerHub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                }
            }
        }
        stage("Push") {
            steps {
                echo "Logging to DockerHub"
                script {
                    image.push()
                }
            }
        }
    }
}