# Deploying a docker-angular-app on a k8s cluster

This repo aims at showing how to dockerize an angular app using a jenkins pipeline through the Jenkins file at first stage, and then how to deploy the application on a k8s cluster using: 
- Deployment definition file
- a LoadBalance service to expose it to external access, yet the loadbalancing task needes to have your cluster hosted on cloud
- Ingress definition file to set a prefix that listens to the defined port
- NetworkPolicy to assure traffic security
- HPA definition file to insure the application scalability and high availability

## Pre-requisites
Here is the list of different softwares to test this application.

- To install the Docker Engine: https://docs.docker.com/desktop/install
- To install local k8s cluster with a single node option to test: https://kubernetes.io/fr/docs/tasks/tools/install-minikube/
- This is an optional if you would like to install jenkins locally  https://www.jenkins.io/doc/book/installing/
- An account on : https://github.com/ is optional
- An account on : https://hub.docker.com/ is needed to store your image


## Dockerize the application using the CI-CD Jenkins Pipeline 
If you didn't install Jenkins locally you can run it instead as a docker image.
- Running Jenkins on Docker Engine: 
```bash
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_data:/var/jenkins_home --network minikube jenkins/jenkins:lts
```
- Use the following command to check the image log in order to get the initial password to start using Jenkins : 
```bash
docker logs -f jenkins
```
- Check this tutorial to know how to launch the pipeline using the Jenkinsfile: https://youtu.be/ZlHaC6sWPdw the video contains some issues resolving.

##### Important notes:
Update in Jenkinsfile the Docker build stage command with your relevant data.
```bash
sh 'docker push username/imagename:tag'
```

## Deploying your application using minikube
- Use the following commands in order to start your cluster minikube : 
```bash
docker context use default
```
```bash
minikube start --driver=docker
```
- Clone or create the yaml definition files on your testing environment

- Create and check the deployment using the following commands:
```bash
kubectl create -f deployment-definition.yaml 
```
```bash
kubectl get deploy 
```

- Create and check the LoadBalancer service using the following commands:
```bash
kubectl create -f service-definition.yaml 
```
```bash
kubectl get svc 
```

- Create and check the Ingress using the following commands:
```bash
kubectl create -f ingress-definition.yaml 
```
```bash
kubectl get ingress 
```

- Create and check the Network Policy using the following commands:
```bash
kubectl create -f network-policy-definition.yaml 
```
```bash
kubectl get networkpolicy
```

- Create and check the Horizontal Pod Autoscaling using the following commands:
```bash
kubectl create -f hpa-definition.yaml 
```
```bash
kubectl get hpa 
```

- You can access your application on your browser using the following command:
```bash
minikube service service-assessment url
```

## Important notes:
- You can skip the previous part if you manage to link Jenkins to minikube as cloud and launch the deployment from pipeline, all you need is un-commant the deploy stage.

- You can run minikube on different VM plateforms as mentionned in the official documentation, yet you need a machine to run the docker image of Jenkins

## Resources and documentations used in this project
- https://docs.docker.com/engine/install/
- https://kubernetes.io/docs/concepts/services-networking/ingress/
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
- https://kubernetes.io/docs/concepts/services-networking/network-policies/
- https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
- https://www.udemy.com/course/learn-kubernetes/
- https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/
- A tutorial on how to link minikube to Jenkins https://youtu.be/fodA9rM5xoo?si=edLLO8znesBm04wl



