pipeline {
    agent {
        node {
            label "CI"
        }
    }
            stages { 
                stage("Clone git repo"){
                    steps {
                        
                        git 'https://DevOps-Batches@dev.azure.com/DevOps-Batches/DevOps49/_git/rs-cart'
                    }
                }
                
               stage('Example') {
                  steps {
                     sh 'echo Hello World!- $(hostname)'
                  }
               }
                     
                stage("npm install") {
                    steps{
                        sh 'npm install'
                    }
               }
                stage("Archieve files"){
                    steps{
                         sh 'tar -czf cart.tgz node_modules cart.js  package.json'
                    }
                }
            
            
            
            }
        }

            
