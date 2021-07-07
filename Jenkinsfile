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
                    CONNECT_STRING=dummy/dummy1@172.17.0.2:1521/ORCLCDB.localdomain
                    sqlplus -s -L /NOLOG <<EOF
                    whenever sqlerror exit 1
                    whenever oserror exit 1
                    CONNECT $CONNECT_STRING
                    exit
                    EOF
                    
                    SQLPLUS_RC=$?
                    echo "RC=$SQLPLUS_RC"
                    [ $SQLPLUS_RC -eq 0 ] && echo "Connected successfully"
                    [ $SQLPLUS_RC -ne 0 ] && echo "Failed to connect"
                    
                    exit SQLPLUS_RC
                   ls -l ${FILENAME}
                   
                   sqlplus dummy/dummy@172.17.0.2:1521/ORCLCDB.localdomain @${FILENAME} </dev/null
                '''
            }
        }
    }
}
