#!/bin/bash
set -e

# APP_NAME="ci-cd-pipeline"
# IMAGE="$1"

# echo "🚀 Deploying image: $IMAGE"

# docker pull $IMAGE

# if docker ps -a | grep -q $APP_NAME; then
#   echo "Stopping existing container..."
#   docker stop $APP_NAME
#   docker rm $APP_NAME
# fi

# docker run -d \
#   --name $APP_NAME \
#   -p 3000:3000 \
#   $IMAGE

# echo "Deployment complete ✅"

APP_NAME="ci-cd-pipeline"
NEW_CONTAINER="${APP_NAME}-green"
OLD_CONTAINER="${APP_NAME}-blue"
IMAGE="$1"

if [ -z "$IMAGE" ]; then
  echo "❌ Image not provided"
  exit 1
fi


echo "🚀 Deploying image: $IMAGE"

docker pull "$IMAGE"

# Clean up any leftover green container from a previous deploy
if docker ps -a --format '{{.Names}}' | grep -q "^${NEW_CONTAINER}$"; then
  echo "🧹 Removing leftover green container"
  docker stop "$NEW_CONTAINER" 2>/dev/null || true
  docker rm "$NEW_CONTAINER" 2>/dev/null || true
fi

echo "▶️ Starting new container on port 3001"
docker run -d \
  --name "$NEW_CONTAINER" \
  -p 3001:3000 \
  "$IMAGE"

./scripts/healthcheck.sh http://localhost:3001/health

echo "🔁 Switching traffic"

if docker ps -a --format '{{.Names}}' | grep -q "^${OLD_CONTAINER}$"; then
  docker stop "$OLD_CONTAINER"
  docker rm "$OLD_CONTAINER"
fi

docker stop "$NEW_CONTAINER"
docker rm "$NEW_CONTAINER"

docker run -d \
  --name "$OLD_CONTAINER" \
  -p 3000:3000 \
  "$IMAGE"

echo "✅ Deployment successful"
