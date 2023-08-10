#!/bin/bash

echo "Destroy the services..."
docker-compose -f docker-compose.yaml down -v
sleep 3
echo "Bring the services back..."
docker-compose -f docker-compose.yaml up -d
