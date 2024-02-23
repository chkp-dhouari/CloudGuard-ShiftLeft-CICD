pipeline {
    agent any
    stages {
        stage('Get Code') {
            steps {
                dir('code-dir') {
                    git branch: 'master',
                    url: 'https://github.com/para93/cta-demo-app'
                }
                sh '''
                    cd code-dir
                    docker build -t mydemoapp .
                    docker save -o mydemoapp.tar mydemoapp
                '''
            }
        }
        stage('CloudGuard_Shiftleft_Code_Scan') {
            environment {
                CHKP_CLOUDGUARD_ID = credentials("CHKP_CLOUDGUARD_ID")
                CHKP_CLOUDGUARD_SECRET = credentials("CHKP_CLOUDGUARD_SECRET")
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
                    sh "shiftleft code-scan -s code-dir -r -2003 -e 500916a9-5e56-4ed4-b9f9-182ea04f968a"
                    } catch (err) {}
                
                }
                
            }
        }
        stage('CloudGuard_Shiftleft_Image_Scan') {
            environment {
                CHKP_CLOUDGUARD_ID = credentials("CHKP_CLOUDGUARD_ID")
                CHKP_CLOUDGUARD_SECRET = credentials("CHKP_CLOUDGUARD_SECRET")
            }
            agent {
                docker {
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp -v $PWD;$PWD -w $PWD'
                    reuseNode true
                }
            }
            steps {
                script {
                    try {
                    sh "shiftleft image-scan -i ./code-dir/mydemoapp.tar -r -2000 -e 500916a9-5e56-4ed4-b9f9-182ea04f968a"
                    } catch (err) {}
                }
            }
        }
        stage('CloudGuard_Shiftleft_IaC') {
            environment {
                CHKP_CLOUDGUARD_ID = credentials("CHKP_CLOUDGUARD_ID")
                CHKP_CLOUDGUARD_SECRET = credentials("CHKP_CLOUDGUARD_SECRET")
            }
            agent {
                docker {
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp/'
                    reuseNode true
                }
            }
            steps {
                sh "shiftleft iac-assessment -i terraform -p code-dir/terraform-template -s Critical -r -64 -e 500916a9-5e56-4ed4-b9f9-182ea04f968a -a mymain.tf"
            }
        }
    }
}
