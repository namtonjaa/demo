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
                credentialsId: '',
                groupId: 'com.example',
                nexusUrl: '192.168.19.15:8081',
                nexusVersion: 'nexus3',
                protocol: 'http',
                repository: '192.168.19.15:8081/ascendcorp/demo',
                version: '0.0.1'
            }
        }
    }
}