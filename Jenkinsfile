pipeline {
  agent {
    node {
      label 'node12' 
    }
  }
  stages {
    stage('Prepare') {
      steps {
        checkout scm
        sh 'npm install -g @nrwl/cli'
        sh 'npm install'        
      }
    }
    stage('Build Processes') {
      stage('Test') {
        steps {
          sh 'nx test nginx-demo'
        }
      }
      stage('Lint') {
        steps {
          sh 'nx lint nginx-demo'
        }
      }
      stage('Build Application') {
          steps {
          sh 'nx build nginx-demo'
        }
      }
      stage('Deploy Application') {
        steps {
          //copy the nginx config to binary build location
          sh 'cp nginx.conf dist/apps/nginx-demo/nginx.conf'
          dir('dist/apps/nginx-demo') {
            sh 'oc start-build nginx --from-dir . --follow'
          }
        }
      }
    }
  }
}
