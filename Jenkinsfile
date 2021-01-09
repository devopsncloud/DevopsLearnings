pipeline {
    agent any
       // node {
         //   label "CI"
       // }
    environment{
        NEXUS = credentials('NexusUserID')
        MAJOR_VERSION = 1
        ITERATION_NUMBER =2
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
                     
               // stage("npm install") {
                    //steps{
                     //   sh 'sudo yum install npm -y'
                  //  }
             //  }
                stage("Archieve files for test"){
                    steps{
                         sh 'tar -czf cart.tgz cart.js  package.json'
                    }
                }
               // stage("upload artifacts"){
                   // steps{ 
                    //  sh 'curl -v -u admin:1earn2e@rN --uploadfile cart.tgz http://3.239.58.248:8081/repository/cart/cart.tgz'
                       //  }
                     //  }
        stage('Upload Artifacts') {
            steps {
                sh '''
                VERSION= "${MAJOR_VERSION}.${ITERATION_NUMBER}.${BUILD_NUMBER}"
                
                mv cart.tgz cart-${VERSION}.tgz
                
                curl -v -u ${NEXUS} --upload-file cart-${VERSION}.tgz http://3.236.235.27:8081/repository/cart/cart-${VERSION}.tgz
                
                
                '''
            }
            
        }
           
                        
        }
}
            
