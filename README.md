# kubernetes-demo

## Install Docker machine driver for KVM

curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 && chmod +x docker-machine-driver-kvm2 && sudo mv docker-machine-driver-kvm2 /usr/local/bin/

###### Install minikube, kubectl

kubectl:
```
sudo apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo apt-get install -y kubelet 
```
minikube:
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.26.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

## Interact with minikube local cluster
```
kubectl cluster-info
kubectl cluster-info dump
kubectl run hello-world --replicas=2 --labels="run=loadbalancer-example" --image=gcr.io/google-samples/node-hello:1.0 --port=8080
kubectl get deployments
kubectl get deployments hello-world
kubectl describe deployments hello-world
kubectl get replicasets
kubectl describe replicasets
kubectl expose deployment hello-world --type=NodePort --name=example-service
kubectl describe service example-service
kubectl get pods --selector="run=loadbalancer-example" --output=wide
kubectl cluster-info
curl http://<CLUSTER-PUBLIC-IP>:<NODE PORT>
kubectl delete service example-service
kubectl delete deployment hello-world
```
###### clone repo

https://github.com/bishnoink/kubernetes-demo.git