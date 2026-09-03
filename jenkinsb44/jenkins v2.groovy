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
                  -Dsonar.host.url=http://3.89.184.84:9000 \\
                  -Dsonar.login=sqp_b4e218337a5bceae2d2bd12a0f8945b302c1b915
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
