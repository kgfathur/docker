#!/bin/bash

docker build -t nginx-certbot:1.22 .

docker tag nginx-certbot:1.22 registry.domain.lab/stream/nginx-certbot:1.0-9
docker push registry.domain.lab/stream/nginx-certbot:1.0-9

docker tag nginx-certbot:1.22 registry.domain.lab/kgfathur/nginx-certbot:1.22
docker push registry.domain.lab/kgfathur/nginx-certbot:1.22

docker tag nginx-certbot:1.22 quay.io/kgfathur/nginx-certbot:1.22
docker push quay.io/kgfathur/nginx-certbot:1.22

docker tag nginx-certbot:1.22 docker.io/kgfathur/nginx-certbot:1.22
docker push docker.io/kgfathur/nginx-certbot:1.22
