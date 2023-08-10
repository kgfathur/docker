#!/bin/bash

docker-compose --env-file env -f docker-compose-test.yaml up -d
echo ""
sleep 10
echo "Step"
docker logs toolbox -t
