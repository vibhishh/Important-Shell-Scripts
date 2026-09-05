#!/bin/bash

LIMIT=1G

echo "Checking files larger than $LIMIT..."

find /var -type f -size +1G -exec ls -lh {} \; 2>/dev/null
