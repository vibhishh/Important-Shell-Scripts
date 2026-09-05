#!/bin/bash

read -p "Enter service name: " SERVICE

if systemctl is-active --quiet "$SERVICE"; then
    echo "OK: $SERVICE is running"
else
    echo "ALERT: $SERVICE is DOWN"
fi
