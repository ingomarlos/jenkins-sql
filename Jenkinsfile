pipeline {
    agent {
        docker {
            image 'sqlplus'
        }
    }
    stages {
        stage('Test Connection') {
            steps {
                sh '''
                    CONNECT_STRING=dummy/dummy@172.17.0.2:1521/ORCLCDB.localdomain
                    sqlplus -s -L /NOLOG <<EOF
                      whenever sqlerror exit sql.sqlcode
                      whenever oserror exit sql.sqlcode
                      CONNECT $CONNECT_STRING
                      exit
                    EOF
                    
                    SQLPLUS_RC=$?
                    echo "RC=$SQLPLUS_RC"
                    [ $SQLPLUS_RC -eq 0 ] && echo "Connected successfully"
                    [ $SQLPLUS_RC -ne 0 ] && echo "Failed to connect"
                    
                    exit SQLPLUS_RC
                '''
            }
        }
        stage('Run Script') {
            steps {
                sh '''
                    sqlplus dummy/dummy@172.17.0.2:1521/ORCLCDB.localdomain <<EOF
                      whenever sqlerror exit sql.sqlcode
                      whenever oserror exit sql.sqlcode
                      @${FILENAME}
                      exit sql.sqlcode
                    EOF
                    echo "Exit code: $?"
                '''
            }
        }
    }
}
