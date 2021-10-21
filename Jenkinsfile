import org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval

def build = Thread.currentThread().toString()
//def regexp= ".+?/job/([^/]+)/.*"
//def match = build  =~ regexp
//def jobName = match[0][1]
println(build)

node {
  try {
    stage('Create job') {
        createJobs()
        }
    } catch(Exception e) {
        if(e.toString() == "hudson.AbortException: script not yet approved for use") {
          approveScript()
          createJobs()
        }
    
    }
}


def approveScript() {

  ScriptApproval scriptApproval = ScriptApproval.get()

  def hashesToApprove = []
  scriptApproval.pendingScripts.each {
    getJobName = it.context.dump().toString()
    println(getJobName)
    if (getJobName.contains("item=account-name/region/resources-type/my-seed-job"))
       {	
        hashesToApprove.add(it.hash) 	
       }
    }

  for (String hash : hashesToApprove) { 	
          scriptApproval.approveScript(hash)
  }
}


def createJobs() {
    jobDsl scriptText: '''
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
    '''
}
