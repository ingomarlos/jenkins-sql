jobList = 
[
'Job01', 
'Job02', 
'Job03'
]

jobList.eachWithIndex { jobName, index ->    println "${index}. Job ${jobName}" 
pipelineJob("job1-${jobName}") { 

  def sshRepo = 'git@github.com:ingomarlos/jenkins-sql.git' 

  description("Your App Pipeline") 
  keepDependencies(false) 

  properties{ 
  
    rebuild { 
      autoRebuild(false) 
    }
  } 

  definition { 
    authorization {
        permission('hudson.model.Item.Discover', 'anonymous')
        permissions('ingo', [
                'hudson.model.Item.Build',
                'hudson.model.Item.Discover',
                'hudson.model.Item.Cancel'
        ])
    }

    folder('project-a') {
      displayName('Project A')
      description('Folder for project A')
    }

    cpsScm { 
      scm { 
        git { 
          remote { 
            url(sshRepo) 
            credentials('sshkey')
          } 
          branches('master') 
          scriptPath('Jenkinsfile') 
          extensions { }  // required as otherwise it may try to tag the repo, which you may not want 
        } 
      } 
    } 
  }
}
}
