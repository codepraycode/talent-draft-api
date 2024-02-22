#!/bin/bash

# Push environement variable to cloud server

rsa_key="~/.ssh/aws-rsa.pem" # Path to ssh key
env_file="./env/.env.production" # Path to file to upload
user=ubuntu # Host username
host=ec2-54-145-24-21.compute-1.amazonaws.com # Host address/Ip
remote_destination="~/live_app/env/.env.production" # File destination on server

echo "Syncing env..."
scp -i $rsa_key $env_file $user@$host:$remote_destination

if [ $? -eq 0 ]; then
    echo "File transfer successful."
else
    echo "File transfer failed."
fi
