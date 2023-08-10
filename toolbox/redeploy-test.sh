#!/bin/bash

echo "Destroy the services..."
docker-compose --env-file env -f docker-compose-test.yaml down -v
sleep 3
echo "Bring the services back..."
docker-compose --env-file env -f docker-compose-test.yaml up -d
echo ""
sleep 10
echo "Step"
docker logs toolbox -t