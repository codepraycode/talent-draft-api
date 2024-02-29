#!/bin/bash

# Bash script to configure firewall  for requests
# source "$(dirname "$(dirname "$0")")/common/functions.sh"

# Check and install Nginx
if command -v nginx &> /dev/null; then
	echo "Nginx is already installed."
else
	echo "Installing Nginx..."
	sudo apt-get update -y
	sudo apt-get upgrade -y
	echo -e "\n\n"
	if sudo apt-get install -y nginx; then
		echo "Nginx installed successfully"
	else
		echo "Failed to install Nginx."
		exit 1
	fi
fi

# Check and install Nginx
if command -v ufw --version &> /dev/null; then
	echo "ufw is already installed."
else
	echo "Installing ufw..."
	sudo apt-get update

	if sudo apt-get install ufw; then
		echo "ufw installed successfully"
	else
		echo "Failed to install ufw."
		exit 1
	fi
fi

echo -e "\n\n"
# Enable Nginx
read -p "Allow what part of Nginx? (HTTP | HTTPS | BOTH): " alw
# alw_l=$(toLowerCase "$alw")
allowed=''

case "$alw" in
	"HTTP") allowed="Nginx HTTP" ;;
	"http") allowed="Nginx HTTP" ;;
	"HTTPS") allowed="Nginx HTTPS" ;;
	"https") allowed="Nginx HTTPS" ;;
	"BOTH") allowed="Nginx FULL" ;;
	"both") allowed="Nginx FULL" ;;
	*) echo "Unknown value given ("$alw"). Exiting."; exit 1 ;;
esac

sudo ufw allow "$allowed"
sudo systemctl status nginx;
