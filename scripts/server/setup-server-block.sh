#!/bin/bash

# Script to register server block for app in nginx

# Ensure environment variables are set
if [ -z "$APP_NAME" ]; then
	echo "APP_NAME not set in environemnt, please set it. Exiting."
	exit 1
fi

# Configuration
echo "Obtaining IP Address..."
DOMAIN_OR_IP=$(curl -s "https://icanhazip.com/")
# Check if the cURL request was successful (HTTP status code 200)
if [ $? -eq 0 ]; then
    echo "✅ Obtained Ip Address."
else
    echo "❌ Error: Could not obtain IP Address."
fi

read -p "Enter App port (defaults to 3333): " APP_PORT
APP_PORT=${APP_PORT:-"3333"} # App server port, cannot be 80


NGINX_CONFIG_FILE="/etc/nginx/sites-available/$APP_NAME"
NGINX_LOG_DIR="/var/log/nginx"
NGINX_ACCESS_LOG="$APP_NAME-access.log"
NGINX_ERROR_LOG="$APP_NAME-error.log"


config="\
server {
    listen 80;
    server_name $DOMAIN_OR_IP;

    location / {
        proxy_pass http://localhost:$APP_PORT;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }

    access_log $NGINX_LOG_DIR/$NGINX_ACCESS_LOG;
    error_log $NGINX_LOG_DIR/$NGINX_ERROR_LOG;
}
"

# Check and install Nginx
if command -v nginx &> /dev/null; then
	echo "✅ Nginx is already installed, checked."
else
	echo "❌ Nginx not installed, make sure to configure server. Exiting"
	exit 1
fi

# Use netstat to check if the port is open
if lsof -i :$APP_PORT ; then
    echo "✅ Found Application ($APP_NAME) running on port $APP_PORT."
else
    echo "❌ Application ($APP_NAME) is not running on port $APP_PORT."
    exit 1
fi


# Create/Update nginx configuration
if [ -f "$NGINX_CONFIG_FILE" ]; then
	# Configuration already exist, update it
	sudo bash -c "cat > $NGINX_CONFIG_FILE" <<EOL
$config
EOL
else
	# Configuration does not exist, create it
	sudo bash -c "cat > $NGINX_CONFIG_FILE" <<EOL
$config
EOL
	sudo ln -s "$NGINX_CONFIG_FILE" /etc/nginx/sites-enabled/
fi

# Test configuration
sudo nginx -t

# Restart nginx
sudo systemctl restart nginx


echo -e "\n\t ✅Nginx configuration for $APP_NAME is successful.\n 🌐 $APP_NAME now available on $DOMAIN_OR_IP"
