pipeline {
    agent any
    environment {
        DOCKER_REPOSITORY = 'ascendcorp/demo-ptvn-scf'
        TAGS = "latest"
        REGISTRY_CREDENTIAL = 'central_login_for_dockerhub'
        REPOSITORY_TAGS ="${DOCKER_REPOSITORY}:${TAGS}"
        NEXUS_URL="192.168.19.15:8082"
        EXECUTE_USER=""
    }

    stages {
        stage('Notification') {
            steps {
                script{
                     EXECUTE_USER = wrap([$class: 'BuildUser']) {
                            sh 'echo ${BUILD_USER}'
                            return env.BUILD_USER
                       }
                    }
            }
        }

        stage('Clean and Compile Project') {
            steps {
                sh 'java -version'
                sh 'mvn clean'
                sh 'mvn compile'
            }
        }

        stage('Build JAR file') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Build Docker Images') {
            steps {
                echo "${DOCKER_REPOSITORY}:${TAGS}"
                script {
                   sh "docker build  -t ${DOCKER_REPOSITORY}:${TAGS}  -f Dockerfile ."
                   sh 'docker images'
                }
            }
        }

        stage('Push Docker Images to Nexus3') {
            steps {
                echo "${DOCKER_REPOSITORY}:${TAGS}"
                script {
                    sh 'docker tag ${DOCKER_REPOSITORY}:${TAGS} ${NEXUS_URL}/${DOCKER_REPOSITORY}:${TAGS}'
                    sh 'docker push ${NEXUS_URL}/${DOCKER_REPOSITORY}:${TAGS}'
                    sh 'docker images'
                }
            }
        }


    }
}