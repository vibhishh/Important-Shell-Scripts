#!/bin/bash

read -p "Enter container name: " CONTAINER

HEALTH=$(docker inspect -f '{{.State.Health.Status}}' "$CONTAINER" 2>/dev/null)

case "$HEALTH" in
    healthy)
        echo "OK: Container is healthy"
        ;;
    unhealthy)
        echo "ALERT: Container is unhealthy"
        ;;
    starting)
        echo "WARNING: Health check is starting"
        ;;
    *)
        echo "No health check configured or container not found"
        ;;
esac
