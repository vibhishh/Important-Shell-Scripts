#!/bin/bash

read -p "Enter namespace: " NAMESPACE
read -p "Enter pod name: " POD

echo "===== Last 100 Lines ====="

kubectl logs "$POD" -n "$NAMESPACE" --tail=100

echo
echo "===== Errors ====="

kubectl logs "$POD" -n "$NAMESPACE" --tail=500 |
grep -iE "error|exception|failed|fatal|panic"
