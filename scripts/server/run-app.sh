#!/bin/bash

# Script to start project on server

read -p "Enter app path (defaults to ~/live_app): " app_path
app_path=${app_path:-~/live_app}

env_path="$app_path/env/.env.production"

# Check if env file is present
if [ -e "$app_path" ]; then
	if [ -e "$env_path" ]; then
		cd "$app_path"

		# Build app
		echo "Building app..."
		npm run build

		# Start app
		pm2 start dist/main.js --name $APP_NAME
	else
		echo "$env_path not available"
	fi
else
	echo "$env_path: App path not specified"
fi
