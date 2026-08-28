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
                  -Dsonar.host.url=http://13.235.134.184:9000 \\
                  -Dsonar.login=sqp_59740791e68737b50e24a9e0e7fe3c110c567775
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
