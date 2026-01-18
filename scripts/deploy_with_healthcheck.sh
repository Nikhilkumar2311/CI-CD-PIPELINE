#!/bin/bash
set -e

APP_NAME="ci-cd-pipeline"
NEW_CONTAINER="${APP_NAME}-new"
OLD_CONTAINER="${APP_NAME}"
IMAGE="$1"

if [ -z "$IMAGE" ]; then
  echo "Image not provided"
  exit 1
fi

echo "🚀 Deploying image: $IMAGE"

# pull image
docker pull "$IMAGE"

# Run new container on temp port
docker run -d \
  --name "$NEW_CONTAINER" \
  -p 3001:3000 \
  "$IMAGE"

echo "⌛ Waiting for health check..."

# Health check loop
for i in {1..10}; do
  if curl -fs http://localhost:3001/health > /dev/null; then
    echo "✅ Health check passed"
    break
  fi

  echo "❌ Health check failed, retrying..."
  sleep 3
done

# Final check
if ! curl http://localhost:3001/health > /dev/null; then
  echo "🚨 Deployment failed - rolling back"
  docker logs "$NEW_CONTAINER"
  docker rm -f "$NEW_CONTAINER"
  exit 1
fi

echo "🔁 Switching traffic..."

# Stop old container
if docker ps -a --format '{{.Names}}' | grep -q "^${OLD_CONTAINER}$"; then
  docker stop "$OLD_CONTAINER"
  docker rm "$OLD_CONTAINER"
fi

# Promote new container
docker stop "$NEW_CONTAINER"
docker rm "$NEW_CONTAINER"

docker run -d \
  --name "$OLD_CONTAINER" \
  -p 3000:3000 \
  "$IMAGE"

echo "🎉 Deployment successful"
