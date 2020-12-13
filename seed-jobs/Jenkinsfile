pipelineJob("Cart-CI") {
  description('CI-JOB Cart-Service')
  definition{
    cpsScm{
      scm{
        git{
          remote{
            url("https://github.com/learn2earnSRK/DevopsLearnings.git")
                 }
          branch("*/master")
        }
      }
      scriptpath("seed-job/jobs.groovy")
    }
  }
}
      
                 
          
          
            
    
