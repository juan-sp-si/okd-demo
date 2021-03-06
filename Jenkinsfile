def templatePath = './deploy/template.yaml' 
def templateName = 'okd-demo' 
pipeline {
    agent {
        node {
            label 'nodejs' 
        }
    }
    options {
        timeout(time: 20, unit: 'MINUTES') 
    }
    stages {
        stage('preamble') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.withProject() {
                            echo "Deploy app to project: ${openshift.project()}"
                        }
                    }
                }
            }
        }
        stage('cleanup') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.withProject() {
                            if (openshift.selector("service", templateName).exists()) { 
                                openshift.selector("service", templateName).delete()
                            }

                            if (openshift.selector("route", templateName).exists()) { 
                                openshift.selector("route", templateName).delete()
                            }

                            if (openshift.selector("deploymentconfig", templateName).exists()) { 
                                openshift.selector("deploymentconfig", templateName).delete()
                            }

                            if (openshift.selector("imagestream", templateName).exists()) { 
                                openshift.selector("imagestream", templateName).delete()
                            }
                            
                            if (openshift.selector("buildconfig", templateName).exists()) { 
                                openshift.selector("buildconfig", templateName).delete()
                            }
                        }
                    }
                }
            }
        }
        stage('create') {
            steps {                
                script {
                    echo "Creating ${templateName} from ${templatePath}"
                    openshift.withCluster() {
                        openshift.withProject() {
                            openshift.newApp(templatePath)
                        }
                    }
                    echo "Created ${templateName}"
                }
            }
        }
        stage('build') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.withProject() {
                            def builds = openshift.selector("bc", templateName).related('builds')
                            timeout(5) { 
                                builds.untilEach(1) {
                                    return (it.object().status.phase == "Complete")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
