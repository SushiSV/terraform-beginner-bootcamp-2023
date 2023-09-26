#!/usr/bin/evn bash

cd /workspace

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform -y

# to install, run this command: $ source ./bin/install_terraform_cli or ./bin/install_terraform_cli

# to give permission to install: chmod u+x ./bin/install_terraform_cli

# to see the file in the folder use command: ls -la ./bin

cd $PROJECT_ROOT

