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
                mv /home/ubuntu/workspace/webserver/target/studentapp-2.2-SNAPSHOT.war   /home/ubuntu/workspace/webserver/target/student.war
                aws s3 cp  /home/ubuntu/workspace/webserver/target/student.war s3://webapp-cbz
                echo "this is build stage"''' 
            }
        }
        stage('Test') {
            steps {
           sh '''mvn clean verify sonar:sonar \\
                  -Dsonar.projectKey=studentapp \\
                  -Dsonar.host.url=http://16.16.206.49:9000 \\
                  -Dsonar.login=sqp_4abcc7f23b5b1ecc30b094be5674ee0fdae37147
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