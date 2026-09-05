#!/bin/bash

THRESHOLD=80

df -hP | awk 'NR>1 {print $5, $6}' | while read usage mount
do
    usage=${usage%\%}

    if [ "$usage" -ge "$THRESHOLD" ]; then
        echo "WARNING: Disk usage on $mount is ${usage}%"
    else
        echo "OK: Disk usage on $mount is ${usage}%"
    fi
done
