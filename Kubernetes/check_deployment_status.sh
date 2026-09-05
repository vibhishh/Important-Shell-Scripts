#!/bin/bash

read -p "Enter namespace: " NAMESPACE

echo "===== Deployments ====="

kubectl get deployments -n "$NAMESPACE"

kubectl get deployments -n "$NAMESPACE" --no-headers |
while read -r NAME READY UP_TO_DATE AVAILABLE AGE
do
    DESIRED=$(echo "$READY" | cut -d/ -f2)
    CURRENT=$(echo "$READY" | cut -d/ -f1)

    if [ "$CURRENT" == "$DESIRED" ]; then
        echo "OK      : $NAME"
    else
        echo "CRITICAL: $NAME - $READY"
    fi
done
