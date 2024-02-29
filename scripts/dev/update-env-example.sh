#!/bin/bash

# Script to create and .env.example file
#   Reads all variable names in any of the other .env files, and create an example file
#   it auto commit the .env.example file
source "$(dirname "$(dirname "$0")")/common/functions.sh"

base_dir=$(getProjectDir)

env_path="$base_dir/env/.env.development"
relative_path="env/.env.example"
env_dest_path="$base_dir/$relative_path"

# Check if the development env exist
if [ -e "$env_path" ]; then
    # Extract the variable name into .env.example
    awk -F= '/^[A-Za-z_][A-Za-z0-9_]*=/ {print $1 "="}' $env_path > $env_dest_path
    echo "Successfully set environement variable template at: $env_dest_path"

    git add "$relative_path"
    git commit -m "Updated .env.example file"
else
    echo "Development env file does not exist, exiting."
    exit 1
fi
