#!/bin/bash

read -p "Enter command names separated by space: " -a COMMANDS

for CMD in "${COMMANDS[@]}"
do
    if command -v "$CMD" &>/dev/null; then
        echo "OK      : $CMD is installed"
    else
        echo "MISSING : $CMD is not installed"
    fi
done
