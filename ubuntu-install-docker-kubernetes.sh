#!/bin/bash

echo "Adding Docker Repository . . ."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu bionic stable"
echo "Done."

echo ""
echo "Adding Kubernetes Repository . . ."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io kubernetes-xenial main
EOF
echo "Done."
echo ""

echo "Installing Docker and Kubernetes . . ."
sudo apt-get -q update
sudo apt-get -q install -y --allow-downgrades docker-ce=18.06.1~ce~3-0~ubuntu kubelet=1.13.5-00 kubeadm=1.13.5-00 kubectl=1.13.5-00
sudo apt-mark -q hold docker-ce kubelet kubeadm kubectl
echo "Done."
echo ""

echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
