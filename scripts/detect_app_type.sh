#!/bin/bash
#Script to check app type.

path="./autodeploy-lite/apps/app1"

if [[ ! -d "$path" ]]; then
    echo "Directory does not exist: $path"
    exit 1
fi

if [[ -f "$path/requirements.txt" ]]; then
    echo "Python App Detected"
    exit 0
elif [[ -f "$path/package.json" ]]; then
    echo "NodeJS App Detected"
    exit 0
elif [[ -f "$path/pom.xml" ]]; then
    echo "Java App Detected"
    exit 0
elif [[ -f "$path/go.mod" ]]; then
    echo "Golang App Detected"
    exit 0
else
    echo "No App Detected in directory, Kindly specify correct directory"
    exit 1
fi
