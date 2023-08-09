#!/bin/bash

docker build -t nginx-rootless:1.22-ubuntu20.04 .

docker tag nginx-rootless:1.22-ubuntu20.04 quay.io/kgfathur/nginx-rootless:1.22-ubuntu20.04
docker push quay.io/kgfathur/nginx-rootless:1.22-ubuntu20.04

docker tag nginx-rootless:1.22-ubuntu20.04 docker.io/kgfathur/nginx-rootless:1.22-ubuntu20.04
docker push docker.io/kgfathur/nginx-rootless:1.22-ubuntu20.04