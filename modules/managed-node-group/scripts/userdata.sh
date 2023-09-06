#!/bin/bash

# Install AWS SSM agent for different OS versions
os_type=$(uname -m)
os_release=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')

if [ "$${os_type}" == "x86_64" ]; then
	if [ "$${os_release}" == "amzn" ]; then
		sudo yum update -y
		sudo yum install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm
	elif [ "$${os_release}" == "debian" ] || [ "$${os_release}" == "ubuntu" ]; then
		mkdir /tmp/ssm && cd /tmp/ssm
		sudo apt-get update
		sudo apt-get install wget -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
		sudo dpkg -i amazon-ssm-agent.deb

	elif [ "$${os_release}" == "centos" ] && [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "8" ] || [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "9" ]; then
		sudo dnf update -y
		sudo dnf install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "centos" ] && [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "7" ]; then
		sudo yum update -y
		sudo yum install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "centos" ] && [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "6" ]; then
		sudo yum update -y
		sudo yum install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/3.0.1479.0/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "rhel" ] && [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "8" ] || [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "9" ]; then
		sudo dnf update -y
		sudo dnf install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "rhel" ] && [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "7" ]; then
		sudo yum update -y
		sudo yum install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "rocky" ]; then
		sudo dnf update -y
		sudo dnf install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "ol" ]; then
		sudo yum update -y
		sudo yum install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "sles" ]; then
		sudo zypper update -y
		sudo zypper install wget awslogs -y
		sudo zypper install -y amazon-ssm-agent
		sudo systemctl start amazon-ssm-agent

	fi
elif [ "$${os_type}" == "aarch64" ]; then
	if [ "$${os_release}" == "amzn" ]; then
		sudo yum update -y
		sudo yum install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_arm64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "debian" ] || [ "$${os_release}" == "ubuntu" ]; then
		sudo apt-get update
		sudo apt-get install wget -y
		mkdir /tmp/ssm && cd /tmp/ssm
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_arm64/amazon-ssm-agent.deb
		sudo dpkg -i amazon-ssm-agent.deb

	elif [ "$${os_release}" == "rhel" ] && [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "8" ] || [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "9" ]; then
		sudo dnf update -y
		sudo dnf install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_arm64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm

	elif [ "$${os_release}" == "rhel" ] && [ "$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"' | awk -F. '{print $1}')" == "7" ]; then
		sudo yum update -y
		sudo yum install wget awslogs -y
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_arm64/amazon-ssm-agent.rpm
		sudo rpm --install amazon-ssm-agent.rpm
	fi
fi

# Check if the SSM agent is running
sudo systemctl status amazon-ssm-agent
