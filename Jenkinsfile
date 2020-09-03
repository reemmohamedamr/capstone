pipeline {
  environment { 
        registry = "reemamr/capstone" 
        registryCredential = 'DockerhubCredentials' 
        dockerImage = '' 
    }
  agent any
  stages {
    stage('Greetings') {
      steps {
        sh 'echo "Hello,Let us start our pipe"'
      }
    }
    stage('Lint HTML') {
      steps {
        sh 'tidy -q -e *.html'
      }
    }
    stage('Lint Dockerfile') {
        steps {
            sh 'hadolint --ignore DL3006 Dockerfile'
        }
    }
    stage('Cloning our Git') { 
        steps { 
            git 'https://github.com/reemmohamedamr/capstone.git' 
        }
    } 
    stage('Building our image') { 
        steps { 
            script { 
                dockerImage = docker.build registry + ":$BUILD_NUMBER" 
            }
        } 
    }
    stage('Deploy our image') { 
        steps { 
            script { 
                docker.withRegistry( '', registryCredential ) { 
                    dockerImage.push() 
                }
            } 
        }
    } 
    stage('Cleaning up') { 
        steps { 
            sh "docker rmi $registry:$BUILD_NUMBER" 
        }
    }
    stage('Kubernetes')  {
            steps {
                sshagent(credentials : ['k8s']) {
                    sh 'ssh -t -t ubuntu@10.0.0.81 -o StrictHostKeyChecking=no "minikube start; kubectl delete --all pods; kubectl run capstone --image=reemamr/capstone --port=80; sleep 5s; kubectl get pods; kubectl port-forward --address 0.0.0.0 capstone 8888:80"'
                }
            }
    }
  }
}