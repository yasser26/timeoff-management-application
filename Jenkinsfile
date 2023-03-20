pipeline {
  agent any
  stages {
    stage ('Checkout from GitHub") {
      checkout changelog: false, scm: scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHubPTA', url: 'https://github.com/yasser26/timeoff-management-application']])        
    }    
  }
}
