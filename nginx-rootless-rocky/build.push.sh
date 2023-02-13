#!/bin/bash

docker build -t nginx-rootless:1.22-rocky .

docker tag nginx-rootless:1.22-rocky registry.domain.lab/stream/nginx-rootless:1.22-rocky-2
docker push registry.domain.lab/stream/nginx-rootless:1.22-rocky-2

docker tag nginx-rootless:1.22-rocky registry.domain.lab/kgfathur/nginx-rootless:1.22-rocky
docker push registry.domain.lab/kgfathur/nginx-rootless:1.22-rocky

docker tag nginx-rootless:1.22-rocky quay.io/kgfathur/nginx-rootless:1.22-rocky
docker push quay.io/kgfathur/nginx-rootless:1.22-rocky

docker tag nginx-rootless:1.22-rocky docker.io/kgfathur/nginx-rootless:1.22-rocky
docker push docker.io/kgfathur/nginx-rootless:1.22-rocky