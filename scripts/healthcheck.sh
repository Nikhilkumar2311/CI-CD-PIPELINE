#!/bin/bash
set -e

URL="$1"
RETRIES=10
SLEEP=3

if [ -z "$URL" ]; then
  echo "❌ Healthcheck URL not provided"
  exit 1
fi

echo "⏳ Running health check on $URL"

for i in $(seq 1 $RETRIES); do
  if curl -fs "$URL" > /dev/null; then
    echo "✅ Health check passed"
    exit 0
  fi

  echo "❌ Attempt $i failed, retrying..."
  sleep $SLEEP
done

echo "🚨 Health check failed"
exit 1
