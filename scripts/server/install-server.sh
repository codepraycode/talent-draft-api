#!/bin/bash

# Bash script to setup server: install required dependencies
# Requirements: curl, nodejs, npm, pm2

# Ensure environment variables are set
if [ -z "$APP_NAME" ]; then
	echo "APP_NAME not set in environemnt, please set it. Exiting."
	exit 1
fi

# Run clean up first
sudo apt-get update
sudo apt-get install -f
sudo apt-get upgrade

# Check and install Nginx
if command -v nginx &> /dev/null; then
	echo "✅ Nginx is already installed, checked"
else
	echo "Nginx not installed, make sure to configure server. Exiting"
	exit 1
fi

# Check and install curl
if command -v curl &> /dev/null; then
	echo "✅ Curl is already installed."
else
	echo "Installing curl..."
	if sudo apt-get install -y curl; then
		echo "✅ Curl installed successfully."
	else
		echo "❌ Failed to install curl."
		exit 1
	fi
fi

# Check and install nodejs version 18
if command -v node &> /dev/null; then
	echo "✅ Nodejs is already installed."
else
	if command -v curl &> /dev/null; then
		echo "Installing Nodejs version 18..."
		if curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs; then
			echo "✅ Node.js version 18 installed successfully."
		else
			echo "❌ Failed to install Node.js version 18."
			exit 1
		fi
	else
		echo "❌ Node.js installation requires curl. Exiting."
		exit 1
	fi
fi

# Install pm2
sudo npm install -g pm2

echo -e "\n\n\t✅ Server setup successful."
