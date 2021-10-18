#!/bin/bash

echo "Destroy the services..."
docker-compose -f docker-compose-test.yaml down -v
sleep 3
echo "Bring the services back..."
docker-compose -f docker-compose-test.yaml up -d
echo ""
sleep 10
echo "Install PHP Extension"
docker exec -it webapp1 /usr/local/bin/docker-php-ext-install mysqli
docker restart webapp1
