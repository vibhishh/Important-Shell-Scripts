#!/bin/bash

read -p "Enter port number: " PORT

if nc -z localhost "$PORT" 2>/dev/null; then
    echo "OK: Port $PORT is OPEN"
else
    echo "ALERT: Port $PORT is CLOSED"
fi
