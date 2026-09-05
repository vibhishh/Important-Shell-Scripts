if [ "$USAGE" -ge 90 ]; then
    echo "CRITICAL: Disk usage is ${USAGE}%"
elif [ "$USAGE" -ge 80 ]; then
    echo "WARNING: Disk usage is ${USAGE}%"
else
    echo "OK: Disk usage is ${USAGE}%"
fi
