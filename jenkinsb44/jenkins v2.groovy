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
                -Dsonar.host.url=http://65.1.3.118:9000 \\
                -Dsonar.login=sqp_d9903291b1b2b44f5b32bd642ab6d971e3e9fcad
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
