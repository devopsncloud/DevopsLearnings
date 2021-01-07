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
                        sh 'sudo yum install npm -y'
                    }
               }
                stage("Archieve files for test"){
                    steps{
                         sh 'tar -czf cart.tgz node_modules cart.js  package.json'
                    }
                }
              //  stage("upload artifacts"){
                 //   steps{ 
                   //     sh 'curl -v -u admin:admin123 --uploadfile cart.tgz http://3.82.15.64:8081/repository/sample/cart.tgz'
                     //       }
          //  }
        }
}
            
