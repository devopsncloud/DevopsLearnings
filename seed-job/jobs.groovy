pipelineJob("Cart-CI") {
  description('CI-JOB Cart-Service')
  definition{
    cpsScm{
      scm{
        git{
          remote{
            url("https://github.com/learn2earnSRK/DevopsLearnings.git/seed-job/jobs.groovy")
                 }
          branch("*/master")
        }
      }
      scriptpath("Jenkinsfile")
    }
  }
}
      
                 
          
          
            
    
