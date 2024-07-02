#!/bin/bash
node_version=14.17.3

# Update yum package index
sudo yum update -y
sudo yum install make
sudo yum groupinstall "Development Tools" -y
sudo yum install jq -y

# Install NGINX
sudo amazon-linux-extras enable nginx1
sudo yum install nginx -y

# Enable NGINX service
sudo systemctl enable nginx
sudo systemctl start nginx
sudo setfacl -R -m u:nginx:rX /home/ec2-user/

# Add NodeSource signing key and repository
sudo yum update -y
sleep 2
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install $node_version
nvm use $node_version
npm install -g yarn
npm install -g serverless@2.72.1
sudo ln -s $(which node) /usr/bin/node
sudo ln -s $(which npm) /usr/bin/npm
sudo ln -s $(which serverless) /usr/bin/serverless
# Local version sls?

# DataDog agent installation
DD_API_KEY=$(aws secretsmanager get-secret-value --secret-id DD_API_KEY --region us-east-1 --query SecretString --output text) DD_AGENT_MAJOR_VERSION=7 bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
sudo sed -i 's/# expvar_port: 5000/expvar_port: 5001/' /etc/datadog-agent/datadog.yaml
sudo service datadog-agent stop

# Install Cloudwatch Agent
sudo yum update -y
sudo yum install -y amazon-cloudwatch-agent
