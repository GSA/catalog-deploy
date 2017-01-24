
def run(playbook, system, environment, resource, tags = null, 
    skippedTags = null)
{
    dir('./ansible') {
        def userName = "ubuntu"
        def credentialsID = getCredentialsId(system, environment, 
                (resource != null) ? resource : playbook)
        def mapping = getDynamicMapping(system, environment, resource)
        def variable = "${playbook}_hosts".replaceAll(/-/, "_")
        def extras = "-i ./inventories/ec2.py"
        extras="${extras}  --extra-vars \"${variable}=${mapping}\""

        // sh "chmod +x ./inventories/ec2.py"
        // sh "./inventories/ec2.py --list"

        if (tags != null) {
            ansiblePlaybook playbook: "./${playbook}.yml",
                sudoUser: userName,
                credentialsId: credentialsID,
                tags: "${tags}",
                skippedTags: "${skippedTags}",
                forks: 5,
                extras: extras
        } else {
            ansiblePlaybook playbook: "./${playbook}.yml",
                sudoUser: userName,
                credentialsId: credentialsID,
                skippedTags: "${skippedTags}",
                forks: 5,
                extras: extras
        }
    }
}

def getCredentialsId(system, environment, resource) {
    def isDev = (environment.startsWith("dev-"))
    def securityContext = ((isDev) ? "dev" : environment)
    return "${env.AWS_REGION}-${system}_${securityContext}_${resource}"
}

def getDynamicMapping(system, environment, resource) {
    return "tag_Name_${system}_${environment}_${resource}".replaceAll(/-/,"_")
}

return this
