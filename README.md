# OKD Pipeline Demo

This is an example project to demostrate how to run a very simple pipeline using OKD and Github.

```bash
oc new-project demo
oc project demo
oc new-app jenkins-ephemeral

oc create secret generic github-ssh \
    --from-file=ssh-privatekey=$HOME/.ssh/id_rsa \
    --type=kubernetes.io/ssh-auth

oc secrets link builder github-ssh

oc create -f deploy/demo-pipeline.yaml

oc start-build okd-pipeline-demo
```
