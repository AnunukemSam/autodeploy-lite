#!/bin/bash
#Script to check app type.

path="$1"
targetdir="./config/app_type.txt"

if [[ ! -d "$path" ]]; then
    echo "Directory does not exist: $path"
    exit 1
fi

if [[ -f "$path/requirements.txt" ]]; then
    echo "Python" > $targetdir
    exit 0
elif [[ -f "$path/package.json" ]]; then
    echo "NodeJS" > $targetdir
    exit 0
elif [[ -f "$path/pom.xml" ]]; then
    echo "Java" > $targetdir
    exit 0
elif [[ -f "$path/go.mod" ]]; then
    echo "Golang" > $targetdir
    exit 0
else
    echo "No App Detected in directory, Kindly specify correct directory"
    exit 1
fi
