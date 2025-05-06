#!/bin/bash
#Script to build and push image to DockerHub

set -e

APP_LOCATION="$1"

if [[ ! -f "./config/.env" || ! -f "./config/app_type.txt" ]]; then
  echo "Missing config files. Make sure .env and app_type.txt exist."
  exit 1
fi

source ./config/.env

IMAGE_NAME=$(basename "$APP_LOCATION")
IMAGE_TAG="${IMAGE_TAG:-latest}"
IMAGE_FULL_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"

APP_TYPE=$(cat ./config/app_type.txt)
echo "Building app of type: $APP_TYPE"

if [[ ! -f $1/Dockerfile ]]; then
    echo "No Dockerfile found in $1"
    exit 1
fi

echo "Building $APP_TYPE app: $IMAGE_FULL_NAME"

if ! docker build -t "$IMAGE_FULL_NAME" "$APP_LOCATION"; then
  echo "Docker build failed."
  exit 1
fi

echo "Logging in to DockerHub..."

if ! docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"; then
  echo "Docker login failed."
  exit 1
fi

echo "Pushing image to DockerHub..."

if docker push "$IMAGE_FULL_NAME"; then
  echo "Docker image pushed successfully: $IMAGE_FULL_NAME"
  exit 0
else
  echo "Docker push failed."
  exit 1
fi

echo "✅ Build and push complete for: $IMAGE_FULL_NAME"