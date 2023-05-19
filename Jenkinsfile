pipeline {
  agent any
  environment {
    SPECTRAL_DSN = credentials('spectral-dsn')
  }
  stages {
    stage('install Spectral') {
      steps {
        sh "curl -L 'https://get.spectralops.io/latest/x/sh?dsn=$SPECTRAL_DSN' | sh"
      }
    }
    stage('scan for issues') {
      steps {
        sh "$HOME/.spectral/spectral scan --ok --engine-kinds spectral packages --include-tags base,audit,iac"
      }
    }
  }
}
