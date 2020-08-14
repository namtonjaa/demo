pipeline {
    agent any
    environment {
        DOCKER_REPOSITORY = '192.168.19.15:8082/ascendcorp/demo'
        REPOSITORY = 'demo'
        TAGS = "latest"
        REPOSITORY_TAGS =" ${DOCKER_REPOSITORY}:${TAGS}"
        REGISTRY_CREDENTIAL = 'b177bdc7-0f89-4b5e-8d5f-bb521bb16c91'
        EXPOSE_PORT= "8080"
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

        stage('Upload .jar file to nexus') {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: '192.168.19.15:8081',
                    groupId: 'com.example',
                    version: '0.0.1',
                    repository: '192.168.19.15:8081/ascendcorp/demo',
                    credentialsId: 'b177bdc7-0f89-4b5e-8d5f-bb521bb16c91',
                    artifacts: [
                        [
                            artifactId: demo,
                            classifier: '',
                            file: 'target/demo-0.0.1.jar',
                            type: 'jar'
                        ]
                    ]
                )
            }
        }
    }
}