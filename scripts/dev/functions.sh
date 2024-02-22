#!/bin/bash

function getProjectDir {
    script_path=$(realpath "$0")
    
    # First level parent dir
    parent_dir=$(dirname "$script_path")
    parent_dir=$(dirname "$parent_dir")
    parent_dir=$(dirname "$parent_dir")
    echo $parent_dir
}