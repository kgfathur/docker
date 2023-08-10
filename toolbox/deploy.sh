#!/bin/bash

docker-compose build
docker-compose --env-file env -f docker-compose.yaml up -d
