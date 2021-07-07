pipeline {
    agent {
        docker {
            image 'sqlplus'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                   ls -l ${FILENAME}
                   exit | sqlplus dummy/dummy1@172.17.0.2:1521/ORCLCDB.localdomain @${FILENAME}
                '''
            }
        }
    }
}
