#!/bin/bash

echo "===== Kubernetes Cluster Health ====="

if ! command -v kubectl &>/dev/null; then
    echo "ERROR: kubectl is not installed"
    exit 1
fi

if ! kubectl cluster-info &>/dev/null; then
    echo "CRITICAL: Kubernetes cluster is not reachable"
    exit 1
fi

echo "OK: Kubernetes cluster is reachable"

echo
echo "===== Nodes ====="
kubectl get nodes

echo
echo "===== Pods ====="
kubectl get pods -A

echo
echo "===== Deployments ====="
kubectl get deployments -A

echo
echo "===== Services ====="
kubectl get services -A
