#!/bin/bash

source "$(dirname "$0")/functions.sh"

base_dir=$(getProjectDir)

env_path="$base_dir/env/.env.development"
env_dest_path="$base_dir/env/.env.example"

# Check if the development env exist
if [ -e "$env_path" ]; then
    # Extract the variable name into .env.example
    awk -F= '/^[A-Za-z_][A-Za-z0-9_]*=/ {print $1 "="}' $env_path > $env_dest_path
    echo "Created template environment variable at: $env_dest_path"
else
    echo "Development env file does not exist, exiting."
    exit 1
fi
