echo "Tryin download and install kubectl"
sudo apt update
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
echo "Checking docker"
sudo apt install docker
sudo usermod -aG docker ${USER}
echo "Tryin to download andinstall minikube"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.20.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
minikube config set driver docker
minikube start --feature-gates=EphemeralContainers=true
eval $(minikube docker-env)
echo "starting pods:"
kubectl run api --image=syr94/sne_project_api:latest --port=9997
kubectl run auth --image=syr94/sne_project_auth:latest --port=9998
docker run -d --name cortex-container -e TZ=UTC -p 32709:9009 ubuntu/cortex:1.11-22.04_beta
docker logs -f cortex-container
kubectl create configmap cortex-config --from-file=main-config=cortex.yaml
kubectl apply -f cortex-deployment.yml
