#!/bin/bash

docker-compose -f docker-compose-test.yaml up -d
echo ""
sleep 10
echo "Step"
docker exec -it nginx-rootless nginx -t
docker restart nginx-rootless
