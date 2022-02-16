pipeline {
  agent { label 'jenkins_slave' }
  stages {
    stage('start') {
      steps {
        script {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
              docker login -u ${USERNAME} -p ${PASSWORD}
              docker build -t mohamedmoselhy110/project:latest .
              docker push mohamedmoselhy110/project:latest
          """
        }
        
      }
      }
    }

    stage('deploy using k8s') {
      steps {
        script {
        withCredentials([file(credentialsId: 'kubeconfig', variable: 'k8s_config')]) {
          sh """
              kubectl apply -f . --kubeconfig=$k8s_config
          """
        }
        
      }
      }
  }
}
}
