#!/bin/bash

docker-compose -f docker-compose-test.yaml up -d
echo ""
sleep 10
echo "Step"
docker exec -it nginx-certbot certbot --version
docker restart nginx-certbot
