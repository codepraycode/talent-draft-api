#!/bin/bash

# Configre git ssh connection to github

# Check if GITHUB_TOKEN is set (in environment)
if [ -z "$GITHUB_TOKEN" ]; then
	echo "Error: GITHUB_TOKEN is not set in environment, please set it and try again."
	exit 1
fi

# Receive github email address
read -p "Enter your Github emaill: " github_email

if [ -z "$github_email" ]; then
	echo "Error: Github email cannot be empty. Exiting."
	exit 1
fi

# Receive key identifier, defaults to "ec2_instance"
read -p "Enter a key identifier (default to ec2_instance): " key_identifier
key_identifier=${key_identifier:-ec2_instance}

# Check if an ssh with same email address already exists
existing_key=""

if [ -f ~/.ssh/id_rsa.pub ]; then
	existing_email=$(ssh-keygen -l -E md5 -f ~/.ssh/id_rsa.pub | awk '{print $3}')
	if [ "$existing_email" == "$github_email" ]; then
		existing_key="true"
	fi
fi

# Generate SSH key if it doesn't exist
if [ -z "$existing_key" ]; then
	ssh-keygen -t rsa -b 4096 -C "$github_email"
	echo "SSH key generated:"
	cat ~/.ssh/id_rsa.pub
else
	echo "SSH key for $github_email already exists. Skipping key generation."
fi

# Add SSH key to Github if no existing key
if [ -z "$existing_key" ]; then
	read -p "Do you want to add this SSh key to your Github account? (y/n): " answer
	if [ "$answer" == "y" ]; then
		echo "Adding SSH key to Github..."
		curl -L \
			-X POST \
			-H "Accept: application/vnd.github+json" \
			-H "Authorization: Bearer $GITHUB_TOKEN" \
			-H "X-GitHub-Api-Version: 2022-11-28" \
			https://api.github.com/user/keys \
			-d "{\"title\":\"$key_identifier\",\"key\":\"$(cat ~/.ssh/id_rsa.pub)\"}"
		echo "SSH key added to Github successfully."
	else
		echo "SSH key not added to Github. You can do it manually later."
	fi
fi
