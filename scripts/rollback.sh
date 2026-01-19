#!/bin/bash
set -e

APP_NAME="ci-cd-pipeline"
IMAGE="$1"

if [ -z "$IMAGE" ]; then
  echo "❌ Rollback image not provided"
  exit 1
fi

echo "⏪ Rolling back to image: $IMAGE"

docker pull "$IMAGE"

if docker ps -a --format '{{.Names}}' | grep -q "^${APP_NAME}$"; then
  docker stop "$APP_NAME"
  docker rm "$APP_NAME"
fi

docker run -d \
  --name "$APP_NAME" \
  -p 3000:3000 \
  "$IMAGE"

echo "✅ Rollback completed"
