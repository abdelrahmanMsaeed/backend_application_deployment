pipeline {
  agent { label 'slave-agent-node' }
  stages {
    stage('start') {
      steps {
        script {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
              docker login -u ${USERNAME} -p ${PASSWORD}
              docker build -t ${USERNAME}/bakehouse:latest .
              docker push ${USERNAME}/bakehouse:latest
          """
        }
        
      }
      }
    }

    stage('deploy using k8s') {
      steps {
        script {
        withCredentials([file(credentialsId: 'kubecongif', variable: 'k8s_config')]) {
          sh """
              gcloud container clusters get-credentials project-cluster --region us-central1 --project active-sun-337308
              kubectl apply -f . --kubeconfig=$k8s_config
          """
        }
        
      }
      }
  }
}