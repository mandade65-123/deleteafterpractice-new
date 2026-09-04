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
                -Dsonar.host.url=http://65.1.3.118:9000 \\
                -Dsonar.login=sqp_d9903291b1b2b44f5b32bd642ab6d971e3e9fcad
                echo "we are in test stage"'''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                sudo curl -L -o /home/ubuntu/apache-tomcat-9.0.121.zip https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.121/bin/apache-tomcat-9.0.121.zip
                sudo unzip /home/ubuntu/apache-tomcat-9.0.121.zip -d /opt/
                sudo aws s3 cp  s3://webapp-cbz/student.war  /opt/apache-tomcat-9.0.121/webapps/
                sudo bash /opt/apache-tomcat-9.0.121/bin/catalina.sh start'''
            }
        }
    }
}