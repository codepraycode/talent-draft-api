#!/bin/bash

# Script to deploy app on a server
# APP_NAME should be set as environment variable

if [ -z "$APP_NAME" ]; then
	echo "APP_NAME is not set in environment, please set it. Exiting."
	exit 1
fi

# Stop pm2 if running
pm2 stop $APP_NAME

repo_link=git@github.com:codepraycode/play-api.git

# set directory name
read -p "Enter directory name (defaults to live_app): " repo_dir
repo_dir=${repo_dir:-live_app}

read -p "Enter branch name (defaults to main): " branch
branch=${branch:-main}



runUpdateFromMain(){
	cd "$repo_dir"
	git pull origin "$branch"
	cd ..
}

runCloneMain(){

        echo "Cloning git repository..."
	git clone -b "$branch" "$repo_link" "$repo_dir"
	
        if [ $? -eq 0 ]; then
                echo "Git repository cloned successfully."
		cd "$repo_dir"
		git log -1 --pretty=format:"%s|%ad"
		cd ..
        else
                echo "Failed to clone git repository"
                exit 1
        fi
}

# Clone repository from github
# Check if the repository is cloned
if [ -d "$repo_dir" ]; then
        echo "Repository already cloned. Updating from $branch branch..."
	runUpdateFromMain
else
	runCloneMain
fi

# Run app setup and installation

# Enter working directory
cd "$repo_dir"

# Install dependecies
echo "Installing dependencies...\n\n"
npm install

echo "Deployment successful."
