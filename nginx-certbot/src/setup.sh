#!/bin/bash

APP_GID=1001
APP_UID=1001
APP_USER=app

apt-get update
apt-get install certbot -y
#apt-get clean
#apt-get autoclean
apt-get clean autoclean
apt-get autoremove --yes
# rm -vrf /var/lib/{apt,dpkg,cache,log}/
# rm -rf /var/lib/apt/lists/*
rm -vrf /var/lib/apt
rm -vrf /var/log/{apt,dpkg.log}

echo "Add User & Group"
addgroup --gid $APP_GID $APP_USER
adduser --disabled-login --ingroup $APP_USER --no-create-home --home /usr/share/nginx --gecos "app user" --shell /bin/false --uid $APP_UID $APP_USER
id $APP_USER

ln -vsf /dev/stdout /var/log/nginx/access.log
ln -vsf /dev/stderr /var/log/nginx/error.log

echo "Prepare file and dir"
rm -vrf /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
mkdir -p /var/run/nginx /tmp/nginx
cp -vrf /src/index.html /usr/share/nginx/html/index.html
cp -vrf /src/nginx.conf /etc/nginx/nginx.conf
cp -vrf /src/default.conf /etc/nginx/conf.d/default.conf

mkdir -vp /var/lib/letsencrypt
mkdir -vp /var/log/letsencrypt
# mkdir -vp /usr/share/nginx/html/.well-known/acme-challenge
mkdir -vp /usr/share/nginx/letsencrypt/.well-known/acme-challenge/

chown -vR $APP_UID:0 /var/log/letsencrypt
chmod -vR g+w /var/log/letsencrypt
chown -vR $APP_UID:0 /var/lib/letsencrypt
chmod -vR g+w /var/lib/letsencrypt
chown -vR $APP_UID:0 /etc/letsencrypt
chmod -vR g+w /etc/letsencrypt
chown -vR $APP_UID:0 /usr/share/nginx/letsencrypt
chmod -vR g+w /usr/share/nginx/letsencrypt

chown -vR $APP_UID:0 /etc/nginx
chmod -vR g+w /etc/nginx
chown -vR $APP_UID:0 /tmp/nginx
chmod -vR g+w /tmp/nginx
chown -vR $APP_UID:0 /var/cache/nginx
chmod -vR g+w /var/cache/nginx
chown -vR $APP_UID:0 /var/log/nginx
chmod -vR g+w /var/log/nginx
chown -vR $APP_UID:0 /var/run/nginx
chmod -vR g+w /var/run/nginx
chown -vR $APP_UID:0 /usr/share/nginx
chmod -vR g+w /etc/nginx
# chown -vR $APP_UID:0 /usr/share/nginx/html/.well-known/acme-challenge
# chmod -vR g+w /usr/share/nginx/html/.well-known/acme-challenge
chown -vR $APP_UID:0 /docker-entrypoint.sh
chown -vR $APP_UID:0 /docker-entrypoint.d

# echo "Verify file & dir"
# echo "## > /etc/nginx"
# ls -laR /etc/nginx
# echo "## > /usr/share/nginx"
# ls -la /usr/share/nginx
# echo "## > /var/tmp/"
# ls -la /var/tmp/
# echo "## > /var/cache/nginx"
# ls -la /var/cache/nginx
# echo "## > /var/run/nginx"
# ls -la /var/run/nginx
# echo "## > /tmp"
# ls -la /tmp

# echo "Checking certbot version..."
# certbot --version
