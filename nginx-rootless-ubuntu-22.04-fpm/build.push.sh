#!/bin/bash

docker build -t nginx-rootless:1.22-ubuntu22.04-fpm .

docker tag nginx-rootless:1.22-ubuntu22.04-fpm registry.i-3.my.id:5500/kgfathur/nginx-rootless:1.22-ubuntu22.04-fpm
docker push registry.i-3.my.id:5500/kgfathur/nginx-rootless:1.22-ubuntu22.04-fpm

docker tag nginx-rootless:1.22-ubuntu22.04-fpm quay.io/kgfathur/nginx-rootless:1.22-ubuntu22.04-fpm
docker push quay.io/kgfathur/nginx-rootless:1.22-ubuntu22.04-fpm

docker tag nginx-rootless:1.22-ubuntu22.04-fpm docker.io/kgfathur/nginx-rootless:1.22-ubuntu22.04-fpm
docker push docker.io/kgfathur/nginx-rootless:1.22-ubuntu22.04-fpm
