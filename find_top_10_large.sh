#!/bin/bash

echo "Top 10 largest files:"

find / -type f -printf '%s %p\n' 2>/dev/null |
sort -nr |
head -10 |
numfmt --field=1 --to=iec
