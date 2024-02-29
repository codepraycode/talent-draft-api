#!/bin/bash
# Script to create environment variable from example template
# To be ran using npm
source "$(dirname "$(dirname "$0")")/common/functions.sh"

base_dir=$(getProjectDir)
env_path="$base_dir/env"
example_path="$env_path/.env.example"

# Check if the development env exist
if [ ! -e "$example_path" ]; then
    echo "No example env file, please create one. Exiting."
    exit 1
else
    # Read what environment to create for
    read -p "For which environment (dev | prod | test)?: " wh
    
    if [ -z "$wh" ]; then
        echo "No environment specified. Exiting."
        exit 1
    else
        if [ "$wh" == "dev" ] || [ "$wh" == "prod" ] || [ "$wh" == "test" ] ; then
            case "$wh" in
                "dev") dest_path="$env_path/.env.development" ;;
                "prod") dest_path="$env_path/.env.production" ;;
                "test") dest_path="$env_path/.env.test" ;;
                *) echo "Unknown environment given ("$wh"). Exiting."; exit 1 ;;
            esac

            cp $example_path $dest_path
            echo -e "\nCreated environment variable at: $(realpath "$dest_path") \nPlease update it.\n"
        else
            exit 1
        fi
    fi
fi
