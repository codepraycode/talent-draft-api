#!/bin/bash

# Push environement variable to cloud server
source "$(dirname "$(dirname "$0")")/common/functions.sh"

base_dir=$(getProjectDir)

read -p "Enter app directory on server (defaults to ~/live_app): " app_dir

app_dir=${app_dir:-"~/live_app"}
source_path="$base_dir/env/.env.production" # Path to file to upload
remote_destination="$app_dir/env/.env.production" # File destination on server

echo "Syncing env..."
# scp -i $rsa_key $source_path $user@$host:$remote_destination
# echo "$source_path $remote_destination"
sendToServer $source_path $remote_destination
