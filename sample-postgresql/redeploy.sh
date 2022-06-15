#!/bin/bash

arg1="$1"
echo "Destroy the services..."
docker-compose -f docker-compose.yaml down -v
sleep 3

if [[ "$arg1" == "clean" ]]; then
  echo "cleaning '/data/psql-1'"
  sudo rm -rf /data/psql-1
  mkdir -p /data/psql-1
fi

echo "Bring the services back..."
docker-compose -f docker-compose.yaml up -d