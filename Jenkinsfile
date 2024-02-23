pipeline {
    agent any
    stages {
        stage('Get Code') {
            steps {
                dir('code-dir') {
                    git branch: 'master',
                    credentialsId: '{chkp-rolandop-git}',
                    url: 'https://github.com/chkp-rolandop/demo-app'
                }
                sh '''
                    cd code-dir
                    docker build -t demo-app .
                    docker save -o demo-app.tar demo-app
                '''
            }
        }
        stage('CloudGuard_Shiftleft_Code_Scan') {
            environment {
                CHKP_CLOUDGUARD_CREDS = credentials('CloudGuard_Credentials')
            }
            agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp/ -v $PWD;$PWD -w $PWD'
                    reuseNode true
                }
            }
            steps {
                script {
                    try {
                    sh '''
                        export CHKP_CLOUDGUARD_ID=$CHKP_CLOUDGUARD_CREDS_USR
                        export CHKP_CLOUDGUARD_SECRET=$CHKP_CLOUDGUARD_CREDS_PSW
                        shiftleft code-scan -s code-dir -r -2003 -e 500916a9-5e56-4ed4-b9f9-182ea04f968a
                    '''
                    } catch (err) {}
                }
            }
        }
        stage('CloudGuard_Shiftleft_Image_Scan') {
            environment {
                CHKP_CLOUDGUARD_CREDS = credentials('CloudGuard_Credentials')
            }
            agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp/ -v $PWD:$PWD -w $PWD'
                    reuseNode true
                }
            }
            steps {
                script{
                        try {
                        sh '''
                            export CHKP_CLOUDGUARD_ID=$CHKP_CLOUDGUARD_CREDS_USR
                            export CHKP_CLOUDGUARD_SECRET=$CHKP_CLOUDGUARD_CREDS_PSW
                            shiftleft image-scan -i ./code-dir/demo-app.tar -r -2002 -e 500916a9-5e56-4ed4-b9f9-182ea04f968a
                        '''
                        } catch (err) {}
                    }
            }
        }
        stage('CloudGuard_Shiftleft_IaC') {
            environment {
                CHKP_CLOUDGUARD_CREDS = credentials('CloudGuard_Credentials')
            }
            agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp/'
                }
            }
            steps {
                dir('iac-code') {
                    git branch: 'master',
                    credentialsId: '{chkp-rolandop-git}',
                    url: 'https://github.com/chkp-rolandop/demo-app'
                }
                sh '''
                    export CHKP_CLOUDGUARD_ID=$CHKP_CLOUDGUARD_CREDS_USR
                    export CHKP_CLOUDGUARD_SECRET=$CHKP_CLOUDGUARD_CREDS_PSW
                    shiftleft iac-assessment -i terraform -p iac-code/terraform-template -s "Critical" -r -64 -e 500916a9-5e56-4ed4-b9f9-182ea04f968a
                '''
            }
        }
    }
}
