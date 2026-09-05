#!/bin/bash

CPU=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')
CPU_INT=${CPU%.*}

if [ "$CPU_INT" -ge 90 ]; then
    echo "CRITICAL: CPU usage is ${CPU}%"
elif [ "$CPU_INT" -ge 80 ]; then
    echo "WARNING: CPU usage is ${CPU}%"
else
    echo "OK: CPU usage is ${CPU}%"
fi

echo ""
echo "Top CPU Consuming PIDs"
echo "-----------------------"
echo ""
ps -eo pid,comm,%cpu --sort=-%cpu | head -6
