#!/bin/bash

read -p "Enter container name: " CONTAINER

if ! docker inspect "$CONTAINER" &>/dev/null; then
    echo "Container does not exist"
    exit 1
fi

STATUS=$(docker inspect -f '{{.State.Status}}' "$CONTAINER")

if [ "$STATUS" = "running" ]; then
    echo "OK: $CONTAINER is running"
else
    echo "ALERT: $CONTAINER is $STATUS"
fi
