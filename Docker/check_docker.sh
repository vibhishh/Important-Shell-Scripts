#!/bin/bash

if command -v docker &>/dev/null; then
    echo "Docker is installed"
    docker --version
else
    echo "Docker is not installed"
    exit 1
fi
