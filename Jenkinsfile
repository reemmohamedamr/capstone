pipeline {
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
    stage('Build Image') {
            steps {
                sh "chmod +x run_docker.sh"
                sh './run_docker.sh'
            }
        }
    stage('Push Docker Image into Docker Hub'){
            steps{
                sh("docker login --username reemamr -p ${0}")
                sh("docker tag capstone reemamr/capstone")
                sh "docker push reemamr/capstone"
            }
        }
  }
}