pipeline {
  agent any

  options {
    skipDefaultCheckout(true)
  }

  stages {
    stage ('Checkout from GitHub') {
      steps {
        checkout changelog: false, scm: scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHubPTA', url: 'https://github.com/yasser26/timeoff-management-application']])        
      }
    }
    
    stage ('Build Time-Managament docker image') {
      steps {
        script {
          timeDockerImage = docker.build "registryyasser/time-app" 
        }
      }
    }
    
    stage ('Push timeDockerImage to ACR') {
      steps {
        script {
          docker.withRegistry("https://registryyasser.azurecr.io", "ACR") {
          timeDockerImage.push()
          }
        }
      }
    }
  }
}
