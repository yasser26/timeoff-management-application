// Pipeline definition
pipeline {
  // Pipeline will be executed by any free agent
  agent any

  // Option to disable default checkout, we want this on a independent stage
  options {
    skipDefaultCheckout(true)
  }
  
  // Stages definition. Pipeline has three principals stages. 
  // Checkout from GitHub: download latest code version from GitHub repo
  stages {
    stage ('Checkout from GitHub') {
      steps {
        checkout changelog: false, scm: scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHubPTA', url: 'https://github.com/yasser26/timeoff-management-application']])        
      }
    }
    // Using the dockerfile, "timeDockerImage" is builded
    stage ('Build timeDockerImage') {
      steps {
        script {
          timeDockerImage = docker.build "registryyasser/time-app" 
        }
      }
    }
    // Docker image pushed and deployed to Azure
    stage ('Push and deploy timeDockerImage to Azure') {
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
