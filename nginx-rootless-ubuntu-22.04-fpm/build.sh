#!/bin/bash

# docker build --no-cache --progress plain -t nginx-rootless:1.22-ubuntu22.04-fpm .
docker build --progress plain -t nginx-rootless:1.22-ubuntu22.04-fpm .
