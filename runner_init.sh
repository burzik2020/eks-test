#!/bin/bash
helmfile_ver=0.142.0
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates \
curl software-properties-common gnupg lsb-release unzip

#terraform cli install
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

#kubectl install
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  
#helm install
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

sudo apt-get update

terraform \
kubectl \
helm

#aws cli install
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install -u
rm -rf awscliv2.zip

#helmfile install
wget -O helmfile_linux_amd64 https://github.com/roboll/helmfile/releases/download/v${helmfile_ver}/helmfile_linux_amd64
chmod +x helmfile_linux_amd64
sudo mv helmfile_linux_amd64 /usr/local/bin/helmfile

#Print OS and tool versions
echo "OS details are: $(uname -a)" && echo ""
echo "AWS Version is $(aws --version)" && echo ""
echo "Kubectl version is $(kubectl version --client)" && echo ""
echo "Terraform version is $(terraform version)" && echo ""
git --version
