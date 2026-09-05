
#!/bin/bash

echo "===== Unhealthy Pods ====="

kubectl get pods -A --no-headers | while read -r NAMESPACE POD READY STATUS REST
do
    case "$STATUS" in
        Running|Completed)
            ;;
        *)
            echo "ALERT: Namespace=$NAMESPACE Pod=$POD Status=$STATUS"
            ;;
    esac
done
