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
                    exit | sqlplus dummy/dummy@172.17.0.2:1521/ORCLCDB.localdomain @${FILENAME}
                '''
            }
        }
    }
}
