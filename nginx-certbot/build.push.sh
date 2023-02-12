#!/bin/bash

docker build -t nginx-certbot:1.22 .
docker tag nginx-certbot:1.22 registry.domain.lab/stream/nginx-certbot:1.0-2
docker push registry.domain.lab/stream/nginx-certbot:1.0-2