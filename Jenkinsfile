pipeline {
    agent any
    environment {
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
                nexusArtifactUploader artifacts: [
                    [
                        artifactId: 'demo',
                        classifier: '',
                        file: 'target/demo-0.0.1.jar',
                        type: 'jar'
                    ]
                ],
                credentialsId: 'b177bdc7-0f89-4b5e-8d5f-bb521bb16c91',
                groupId: 'com.example',
                nexusUrl: '192.168.19.15:8081',
                nexusVersion: 'nexus3',
                protocol: 'http',
                repository: 'http://192.168.19.15:8081/repository/docker',
                version: '0.0.1'
            }
        }
    }
}