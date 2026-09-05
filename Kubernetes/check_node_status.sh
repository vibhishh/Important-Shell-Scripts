#!/bin/bash

echo "===== Kubernetes Node Status ====="

kubectl get nodes --no-headers | while read -r NAME STATUS ROLES AGE VERSION
do
    if [[ "$STATUS" == "Ready" ]]; then
        echo "OK      : $NAME is Ready"
    else
        echo "CRITICAL: $NAME is $STATUS"
    fi
done
