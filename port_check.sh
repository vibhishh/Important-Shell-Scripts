#!/bin/bash

HOST="localhost"

for PORT in 22 80 443 3306 5432 8080 8000 3000
do
    if nc -z "$HOST" "$PORT" 2>/dev/null; then
        echo "Port $PORT : OPEN"
    else
        echo "Port $PORT : CLOSED"
    fi
done
