#!/bin/bash

# Sends script to server online
# echo "$(dirname "$(dirname "$0")")"
source "$(dirname "$(dirname "$0")")/common/functions.sh"

base_dir=$(getProjectDir)

if [ -z "$1" ]; then
    echo "❌ Script path is required. Exiting."
    exit 1
fi

source_path="$base_dir/scripts/$1" # Path to file to upload

if [ -z "$2" ]; then
    # remote_destination={$2:-~/$1} # File destination on server
    echo "Path to save file in destination not provided, using default..."
fi
# dest_path="$2"
# remote_destination=${dest_path:-~/$1} # File destination on server
remote_destination="~/$2" # File destination on server


# echo "$source_path $remote_destination"
sendToServer $source_path $remote_destination
