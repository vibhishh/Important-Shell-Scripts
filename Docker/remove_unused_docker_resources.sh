#!/bin/bash

echo "Cleaning unused Docker resources..."

docker container prune -f
docker image prune -f
docker network prune -f

echo "Cleanup completed"
