#!/bin/bash

user=ubuntu # Host username
host=ec2-3-90-69-167.compute-1.amazonaws.com # Host address/Ip
# remote_destination="~/live_app/env/" # File destination on server


function getProjectDir {
    script_path=$(realpath "$0")
    
    # First level parent dir
    parent_dir=$(dirname "$script_path")
    parent_dir=$(dirname "$parent_dir")
    parent_dir=$(dirname "$parent_dir")
    echo $parent_dir
}

function toLowerCase {
    lowercase_string=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    echo "$lowercase_string"
}

function sendToServer {
    if [ -z "$1" ]; then
        echo "Path to file to transfer is required ❌. Exiting."
        exit 1
    else
        if [ -z "$2" ]; then
            echo "Path to save file in destination is required ❌. Exiting"
            exit 1
        fi
    fi

    read -p "Enter path to server ssh key (default to ~/projects/talent-draft/remote/aws-rsa-1.pem): " rsa_key
    rsa_key=${rsa_key:-~/projects/talent-draft/remote/aws-rsa-1.pem} # Path to ssh key
    
    echo "Transfering file..."
    scp -i $rsa_key $1 $user@$host:$2

    if [ $? -eq 0 ]; then
        echo "File transfer successful ✅."
    else
        echo "File transfer failed ❌."
    fi

}