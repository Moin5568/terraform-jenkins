#!/bin/bash

#install jenkins
sudo apt update -y
sudo apt update docker.io -y
sudo chmod 666 /var/run/docker.sock
docker run -d --name jenkins -p 8080:8080 jenkins/jenkins -y

# install git
sudo apt install git -y

# install terraform

sudo apt-get install unzip
https://www.terraform.io/downloads.html
wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip
unzip terraform_1.0.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version 

