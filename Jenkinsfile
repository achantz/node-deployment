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
            sh 'nx affected:test --parallel --maxParallel=5'
          }
        }
        stage('Lint') {
          steps {
            sh 'nx affected:lint --parallel --maxParallel=5'
          }
        }
        stage('Build Application') {
           steps {
            sh 'npx build nginx-demo --prod'
          }
        }
        stage('Deploy Application') {
          steps {
            //copy the nginx config to binary build location
            sh 'cp nginx.conf ./dist/nginx.conf'   
            dir('dist') {
              sh 'oc start-build ui-components --from-dir . --follow'
            }
          }
        }
      }
    }
  }
}
