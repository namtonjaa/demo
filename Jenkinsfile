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
                        artifactId: 'spring-boot-starter-parent',
                        classifier: '',
                        file: 'target/demo-0.0.1.jar',
                        type: 'jar'
                    ]
                ],
                credentialsId: '',
                groupId: 'org.springframework.boot',
                nexusUrl: '192.168.19.15:8081',
                nexusVersion: 'nexus3',
                protocol: 'http',
                repository: 'docker/v2/ascendcorp',
                version: '2.3.2.RELEASE'
            }
        }
    }
}