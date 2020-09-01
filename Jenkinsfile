pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'echo "Hello World"'
      }
    }
    stage('Lint HTML') {
      steps {
        sh 'tidy -q -e *.html'
      }
    }
    stage('Upload to AWS') {
      steps {
        withAWS(region:'us-west-2',credentials:'admin') {
          s3Upload(pathStyleAccessEnabled:true, payloadSigningEnabled: true, file:'index.html', bucket:'c3pipelines')
        }
      }
    }
  }
}