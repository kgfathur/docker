#!/bin/bash

docker build -t nginx-rootless:1.22 .
docker tag nginx-rootless:1.22 registry.domain.lab/stream/nginx-rootless:1.22
docker push registry.domain.lab/stream/nginx-rootless:1.22
docker tag nginx-rootless:1.22 registry.domain.lab/kgfathur/nginx-rootless:1.22
docker push registry.domain.lab/kgfathur/nginx-rootless:1.22