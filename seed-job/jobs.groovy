pipelineJob("Cart-CI") {
  description('CI-JOB Cart-Service')
  definintion{
    cpsScm{
      scm{
        git{
          remote{
            url("https://github.com/learn2earnSRK/DevopsLearnings.git")
                 }
          branch("*/master")
        }
      }
      scriptpath("Jenkinsfile")
    }
  }
}
      
                 
          
          
            
    
