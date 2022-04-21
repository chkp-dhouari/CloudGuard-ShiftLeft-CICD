pipeline {
      agent any
      environment {
           CHKP_CLOUDGUARD_ID = credentials("CHKP_CLOUDGUARD_ID")
           CHKP_CLOUDGUARD_SECRET = credentials("CHKP_CLOUDGUARD_SECRET")
      }
        
  stages {
          
         stage('Clone Github repository') {
         
             steps {
              
             checkout scm
           
             }
  
          }
          
    stage('webapp Docker image Build and scan prep') {
             
            steps {

              sh 'docker build -t checkpoint/shiftleft .'
              sh 'docker save checkpoint/shiftlef -o chkpshiftleft01.tar'              
            }
    }
    stage('ShiftLeft Container Image Scan') { 
          
          agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp/
                }
                
          }
          steps {
                dir('code-dir') {
                    git branch: '{banch}',
                    credentialsId: '{jenkins_credentials_id_for_git_credentials}',
                    url: {git_repo_url}'
                }
                sh 'shiftleft image-scan -s code-dir -r {rulesetId} -e {environmentId}'
                
          }
          
       }
                  
    stage('CloudGuard_Shiftleft_Code_Scan') {    
           
            agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp/'
                }
            }
            steps {
                dir('code-dir') {
                    git branch: '{banch}',
                    credentialsId: '{jenkins_credentials_id_for_git_credentials}',
                    url: {git_repo_url}'
                }
                sh 'shiftleft code-scan -s code-dir -r {rulesetId} -e {environmentId}'
            }
      }
      stage('CloudGuard_Shiftleft_IaC') {
         
            agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                    args '-v /tmp/:/tmp/'
                }
            }
            steps {
                dir('iac-code') {
                    git branch: '{banch}',
                    credentialsId: '{jenkins_credentials_id_for_git_credentials}',
                    url: {git_repo_url}'
                }
                sh 'shiftleft iac-assessment -i terraform -p iac-code/terraform-template -r {rulesetId} -e {environmentId}'
            }
      }
}
