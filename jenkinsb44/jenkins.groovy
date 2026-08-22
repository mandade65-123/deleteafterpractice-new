pipeline {
    agent any 
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
                sh 'echo "this is Test stage"'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo "this is Deploy stage"'
            }
        }
    }
}
