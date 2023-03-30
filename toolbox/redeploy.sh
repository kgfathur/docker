#!/bin/bash

echo "Destroy the services..."
docker-compose --env-file env -f docker-compose.yaml down -v
sleep 3
echo "Bring the services back..."
docker-compose --env-file env -f docker-compose.yaml up -d