#!/bin/bash

docker-compose build
docker-compose -f docker-compose.yaml up -d
