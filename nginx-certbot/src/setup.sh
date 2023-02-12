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
adduser --disabled-login --ingroup $APP_USER --no-create-home --home /nonexistent --gecos "app user" --shell /bin/false --uid $APP_UID $APP_USER
id $APP_USER

echo "Prepare file and dir"
mkdir -p /var/run/nginx
cp -vrf /src/index.html /usr/share/nginx/html/index.html
cp -vrf /src/nginx.conf /etc/nginx/nginx.conf
cp -vrf /src/default.conf /etc/nginx/conf.d/default.conf

# cat /etc/nginx/nginx.conf

chown -vR $APP_UID:$APP_GID /var/cache/nginx
# chmod -vR g+w /var/cache/nginx
chown -vR $APP_UID:$APP_GID /etc/nginx
# chmod -vR g+w /etc/nginx
chown -vR $APP_UID:$APP_GID /usr/share/nginx /var/run/nginx
chown -vR $APP_UID:$APP_GID /docker-entrypoint.sh
chown -vR $APP_UID:$APP_GID /docker-entrypoint.d

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
