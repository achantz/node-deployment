def publishNpm = false
def deployStorybook = false;
def base = '';
def baseCommand = ''
def generateNpmrc(){
	sh "echo \"@abgov:registry=https://registry.npmjs.org/\" >> ~/.npmrc"
	
	sh "echo \"//registry.npmjs.org/:_authToken=21d6856c-6376-4f64-a27e-6533bd4bc8c7\" > ~/.npmrc"
}


pipeline {
  agent {
    node {
      label 'node12' 
    }
  }
  options {
    // set a timeout of 20 minutes for this pipeline
    // timeout(time: 20, unit: 'MINUTES')
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
        stage('Test'){
          steps {
            sh "nx affected:test --parallel --maxParallel=5"
          }
        }
        stage('Lint'){
          steps {
            sh "nx affected:lint --parallel --maxParallel=5"
          }
        }
        stage('Build Application'){
           steps {
            sh 'npx ng build nginx-demo
          }
        }
      }
    }
    stage('Deploy Test') {
      stage('Storybook'){
          steps {
            //copy the nginx config to binary buld location
            sh "cp nginx.conf dist"   
            dir('dist') {
              sh "oc start-build ui-components --from-dir . --follow"
            }
          }
        }  
    }

    // stage('Deploy Prod') {
    //   parallel {
    //     stage('Storybook'){
    //       when {
    //         expression { deployStorybook == true }
    //       }
    //       steps {
    //         echo 'placeholder'
    //       }
    //     }
    //     stage('Publish to npm'){
    //       when {
    //         expression { publishNpm == true }
    //       }
    //       steps {
    //         generateNpmrc()
    //         sh 'npm run publish:npm'
    //       }
    //     }
    //   }
    //}
  }
}
