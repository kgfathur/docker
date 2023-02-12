#!/bin/bash

docker build -t nginx:1.22-rootless .
docker tag nginx:1.22-rootless registry.domain.lab/stream/nginx:1.22-rootless
docker push registry.domain.lab/stream/nginx:1.22-rootless