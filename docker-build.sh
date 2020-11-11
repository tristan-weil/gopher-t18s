#!/bin/bash

set -o errexit
set -o pipefail

echo "Building Docker..."
docker build -t latest .

echo "Starting Docker..."
docker run -it --rm --name gopher-t18s -p 7070:7070 latest
