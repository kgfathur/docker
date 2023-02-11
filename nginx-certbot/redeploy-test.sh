#!/bin/bash

echo "Destroy the services..."
docker-compose -f docker-compose-test.yaml down -v
sleep 3
echo "Bring the services back..."
docker-compose -f docker-compose-test.yaml up -d
echo ""
sleep 10
echo "Step"
docker exec -it nginx-certbot certbot --version
docker restart nginx-certbot
