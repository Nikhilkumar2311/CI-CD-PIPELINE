#!/bin/bash
set -e

APP_NAME="ci-cd-pipeline"
IMAGE="$1"

echo "🚀 Deploying image: $IMAGE"

docker pull $IMAGE

if docker ps -a | grep -q $APP_NAME; then
  echo "Stopping existing container..."
  docker stop $APP_NAME
  docker rm $APP_NAME
fi

docker run -d \
  --name $APP_NAME \
  -p 3000:3000 \
  $IMAGE

echo "Deployment complete ✅"
