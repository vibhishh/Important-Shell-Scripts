#!/bin/bash

echo "===== CrashLoopBackOff Pods ====="

kubectl get pods -A | grep "CrashLoopBackOff"

if [ $? -eq 0 ]; then
    echo
    echo "ALERT: CrashLoopBackOff pods found"
    exit 1
else
    echo "OK: No CrashLoopBackOff pods"
fi
