#!/bin/bash

read -p "Enter process name: " PROCESS

PID=$(pgrep -x "$PROCESS")

if [ -n "$PID" ]; then
    echo "OK: $PROCESS is running"
    echo "PID: $PID"
else
    echo "ALERT: $PROCESS is NOT running"
fi
