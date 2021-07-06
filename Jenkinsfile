pipeline {
    agent {
        docker {
            image 'sqlplus'
        }
    }
    stages {
        stage('Build') {
            parameters {
                 string defaultValue: 'SCRIPT001.SQL', name: 'FILENAME'
            }
            steps {
                sh '''
                    echo exit | sqlplus dummy/dummy@172.17.0.2:1521/ORCLCDB.localdomain @TICKET001.sql
                    echo ${FILENAME}
                '''
            }
        }
    }
}
