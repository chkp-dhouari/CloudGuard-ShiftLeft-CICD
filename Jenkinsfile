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
              sh 'docker save checkpoint/shiftleft -o chkpshiftleft01.tar'              
            }
    }
    stage('ShiftLeft Container Image Scan') { 
          
          agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                    
                }
                
          }
          steps {
                dir('code-dir') {
                    git branch: '{banch}',
                    credentialsId: '{jenkins_credentials_id_for_git_credentials}',
              
                sh 'shiftleft image-scan -s code-dir -r {rulesetId} -e {environmentId}'
                
          }
          
       }
                  
    stage('CloudGuard_Shiftleft_Code_Scan') {    
           
            agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                   
                }
            }
            steps {
                dir('code-dir') {
                    git branch: '{banch}',
                    credentialsId: '{jenkins_credentials_id_for_git_credentials}',
                
                sh '''shiftleft code-scan -s code-dir -r {rulesetId} -e {environmentId}'''
            }
      }
      stage('CloudGuard_Shiftleft_IaC') {
         
            agent {
                docker { 
                    image 'checkpoint/shiftleft:latest'
                   
                }
            }
            steps {
                dir('iac-code') {
                    git branch: '{banch}',
                    credentialsId: '{jenkins_credentials_id_for_git_credentials}',
                   
                sh 'shiftleft iac-assessment -i terraform -p iac-code/terraform-template -r {rulesetId} -e {environmentId}'
            }
      }
}
