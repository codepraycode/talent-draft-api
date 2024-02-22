#!/bin/bash

# Script to register server block for app in nginx

# Configuration
DOMAIN_OR_IP="54.145.24.21"
APP_PORT="3333" # App server port, cannot be 80
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

# Nginx must be installed
if ! command -v nginx &> /dev/null; then
	echo "Nginx must be installed. Exiting."
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


echo "Nginx configuration for $APP_NAME is successful."
