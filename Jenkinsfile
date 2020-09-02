pipeline {
  environment { 
        registry = "reemmohamedamr/capstone" 
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
  }
}