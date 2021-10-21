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
    String seedJob = new File('seedjob.dsl').getText('UTF-8')
    jobDsl scriptText: ${seedJob}
}
