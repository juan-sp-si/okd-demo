# OKD Pipeline Demo

This is an example project to demostrate how to run a very simple pipeline using OKD and Github.

```bash
# create a new project
oc new-project demo

# or if you already have the project make sure you enter it
oc project demo

# create a new app based on Jenkins ephimeral
oc new-app jenkins-ephemeral

# you will need a github ssh secret for Jenkins to pull the source
oc create secret generic github-ssh --from-file=ssh-privatekey=$HOME/.ssh/id_rsa --type=kubernetes.io/ssh-auth

# link this secret to the builder service account so jenkins can use it
oc secrets link builder github-ssh

# create the Pipeline BuildConfig
oc apply -f deploy/demo-pipeline.yaml

# trigger the pipeline
oc start-build okd-pipeline-demo
```
