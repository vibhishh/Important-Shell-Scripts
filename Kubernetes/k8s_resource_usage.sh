#!/bin/bash

echo "===== Node Resources ====="

kubectl top nodes

echo
echo "===== Pod Resources ====="

kubectl top pods -A

echo
echo "===== Top CPU Pods ====="

kubectl top pods -A --sort-by=cpu | head

echo
echo "===== Top Memory Pods ====="

kubectl top pods -A --sort-by=memory | head
