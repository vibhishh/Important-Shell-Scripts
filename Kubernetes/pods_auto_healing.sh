#!/bin/bash

NAMESPACE="default"

echo "===== Kubernetes Auto-Healing Check ====="

kubectl get pods -n "$NAMESPACE" --no-headers |
while read -r POD READY STATUS REST
do

    case "$STATUS" in

        CrashLoopBackOff|Error|Failed)
            echo "ALERT: $POD is $STATUS"

            echo "Deleting pod..."
            kubectl delete pod "$POD" -n "$NAMESPACE"

            echo "Pod deleted. Kubernetes should recreate it."
            ;;

        Pending)
            echo "WARNING: $POD is Pending"
            ;;

        Running)
            echo "OK: $POD is Running"
            ;;

        *)
            echo "INFO: $POD status = $STATUS"
            ;;

    esac

done
