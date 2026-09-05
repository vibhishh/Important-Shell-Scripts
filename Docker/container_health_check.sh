#!/bin/bash

echo "======================================"
echo "      DOCKER CONTAINER HEALTH"
echo "======================================"

docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"

echo "======================================"
