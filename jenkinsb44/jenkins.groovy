pipeline {
    agent {label 'webserver'}
    stages {
        stage('Pull') {
            steps {
                sh 'echo "this is pull stage"'
                git 'https://github.com/mandade65-123/studentapp-ui.git'
            }
        }
        stage('Build') {
            steps {
                sh '''mvn clean package
                echo "this is build stage"'''
            }
        }
        stage('Test') {
            steps {
               sh '''mvn clean verify sonar:sonar \\
                      -Dsonar.projectKey=studentapp \\
                      -Dsonar.host.url=http://13.201.96.154:9000 \\
                      -Dsonar.login=sqp_92c3efd84387e64f16e74307e20ce5fb67fef484
                        echo "we are in test stage"'''
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo "this is Deploy stage"'
            }
        }
    }
}
