#!/bin/bash

echo "## -- OS Info"
cat /etc/os-release

echo "## -- NGINX Version"
nginx -V

echo "## -- Certbot Version"
certbot --version

echo "## --> /var/log/letsencrypt"
ls -lh /var/log/letsencrypt
echo "## --> /var/lib/letsencrypt"
ls -lh /var/lib/letsencrypt
echo "## --> /etc/letsencrypt"
ls -lh /etc/letsencrypt

echo "## --> /etc/nginx"
ls -lh /etc/nginx
echo "## --> /tmp/nginx"
ls -lh /tmp/nginx
echo "## --> /var/cache/nginx"
ls -lh /var/cache/nginx
echo "## --> /var/log/nginx"
ls -lh /var/log/nginx
echo "## --> /var/run/nginx"
ls -lh /var/run/nginx
echo "## --> /usr/share/nginx"
ls -lh /etc/nginx
