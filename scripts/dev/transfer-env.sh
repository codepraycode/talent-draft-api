#!/bin/bash

# Push environement variable to cloud server
source "$(dirname "$0")/functions.sh"

base_dir=$(getProjectDir)

source_path="$base_dir/env/.env.production" # Path to file to upload

user=ubuntu # Host username
host=ec2-54-145-24-21.compute-1.amazonaws.com # Host address/Ip
remote_destination="~/live_app/env/.env.production" # File destination on server

read -p "Enter path to server ssh key (default to ~/.ssh/aws-rsa.pem): " rsa_key
rsa_key=${rsa_key:-~/.ssh/aws-rsa.pem} # Path to ssh key

echo "Syncing env..."
scp -i $rsa_key $source_path $user@$host:$remote_destination

if [ $? -eq 0 ]; then
    echo "File transfer successful."
else
    echo "File transfer failed."
fi
