#!/bin/bash

IMAGE_NAME="myapp"
CONTAINER_NAME="myapp-container"
PORT=8080

echo "======================================"
echo "     DOCKER BUILD & DEPLOY"
echo "======================================"

# Check Docker
if ! command -v docker &>/dev/null; then
    echo "ERROR: Docker is not installed."
    exit 1
fi

# Build image
echo "Building Docker image..."

docker build -t "$IMAGE_NAME:latest" .

if [ $? -ne 0 ]; then
    echo "ERROR: Docker build failed."
    exit 1
fi

echo "SUCCESS: Image built."

# Remove old container if exists
if docker ps -a --format '{{.Names}}' | grep -qx "$CONTAINER_NAME"; then
    echo "Removing old container..."
    docker rm -f "$CONTAINER_NAME"
fi

# Run new container
echo "Starting new container..."

docker run -d \
    --name "$CONTAINER_NAME" \
    -p "$PORT:8000" \
    "$IMAGE_NAME:latest"

if [ $? -eq 0 ]; then
    echo "SUCCESS: Container deployed."
else
    echo "ERROR: Container deployment failed."
    exit 1
fi

# Check container
sleep 3

if docker ps --format '{{.Names}}' | grep -qx "$CONTAINER_NAME"; then
    echo "SUCCESS: $CONTAINER_NAME is running."
else
    echo "ERROR: Container is not running."
    docker logs "$CONTAINER_NAME"
    exit 1
fi

echo "======================================"
echo "Deployment completed successfully."
echo "Application: http://localhost:$PORT"
echo "======================================"
