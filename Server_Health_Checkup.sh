#!/bin/bash

echo "=========================================="
echo "       SERVER HEALTH CHECK REPORT"
echo "=========================================="
echo "Hostname      : $(hostname)"
echo "Date & Time   : $(date)"
echo "Uptime        : $(uptime -p)"
echo "=========================================="

# CPU Usage
echo ""
echo "----- CPU USAGE -----"

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
printf "CPU Usage     : %.2f%%\n" "$CPU"

# Memory Usage
echo ""
echo "----- MEMORY USAGE -----"

free -h

MEMORY=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
echo "Memory Usage  : ${MEMORY}%"

# Disk Usage
echo ""
echo "----- DISK USAGE -----"

df -h --output=target,pcent | grep -vE '^Mounted|/snap'

# Root filesystem usage
DISK=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
echo "Root Disk     : ${DISK}%"

# Load Average
echo ""
echo "----- LOAD AVERAGE -----"
uptime

# Top Processes
echo ""
echo "----- TOP 5 CPU PROCESSES -----"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6

echo ""
echo "----- TOP 5 MEMORY PROCESSES -----"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6

# Running Services
echo ""
echo "----- FAILED SERVICES -----"

systemctl --failed --no-pager

# Network
echo ""
echo "----- NETWORK -----"

ip -br addr

# Internet connectivity
echo ""
echo "----- INTERNET CONNECTIVITY -----"

if ping -c 2 -W 2 8.8.8.8 > /dev/null 2>&1
then
    echo "Internet      : UP"
else
    echo "Internet      : DOWN"
fi

# Disk Alerts
echo ""
echo "----- DISK ALERT -----"

if [ "$DISK" -ge 80 ]; then
    echo "WARNING: Root disk usage is above 80%"
else
    echo "Disk Status   : OK"
fi

# Memory Alert
if (( $(echo "$MEMORY >= 80" | bc -l) )); then
    echo "WARNING: Memory usage is above 80%"
else
    echo "Memory Status : OK"
fi

# CPU Alert
if (( $(echo "$CPU >= 80" | bc -l) )); then
    echo "WARNING: CPU usage is above 80%"
else
    echo "CPU Status    : OK"
fi

echo ""
echo "=========================================="
echo "       HEALTH CHECK COMPLETED"
echo "=========================================="
