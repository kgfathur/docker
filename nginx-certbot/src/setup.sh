#!/bin/bash

apt-get update
apt-get install certbot -y
#apt-get clean
#apt-get autoclean
apt-get clean autoclean
apt-get autoremove --yes
# rm -vrf /var/lib/{apt,dpkg,cache,log}/
# rm -rf /var/lib/apt/lists/*
rm -vrf /var/lib/apt
rm -vrf /var/log/{apt,dpkg.log,nginx/*}

cp -vrf /src/index.html /usr/share/nginx/html/index.html
cp -vrf /src/nginx.conf /etc/nginx/nginx.conf
cp -vrf /src/default.conf /etc/nginx/conf.d/default.conf

echo "Checking NGINX config & reload..."
nginx -t
nginx -s reload

echo "Checking certbot version..."
certbot --version
