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
      parallel {
        stage('Test') {
          steps {
            sh 'nx affected --target=test --all --parallel'
          }
        }
        stage('Lint') {
          steps {
            sh 'nx affected --target=lint --all --parallel'
          }
        }
        stage('Build Application') {
           steps {
            sh 'nx affected --target=build'
          }
        }
        stage('Deploy Application') {
          steps {
            //copy the nginx config to binary build location
            sh 'cp nginx.conf dist/nginx.conf'   
            dir('dist') {
              sh 'oc start-build nginx --from-dir . --follow'
            }
          }
        }
      }
    }
  }
}
