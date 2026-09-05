#!/bin/bash

THRESHOLD=80

CPU=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')

CPU_INT=${CPU%.*}

if [ "$CPU_INT" -ge "$THRESHOLD" ]; then
    echo "ALERT: CPU usage is ${CPU}%"
else
    echo "OK: CPU usage is ${CPU}%"
fi
