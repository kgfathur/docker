#!/bin/bash

APP_GID=1001
APP_UID=1001
APP_USER=app

echo "Add User & Group"
addgroup --gid $APP_GID $APP_USER
adduser --disabled-login --ingroup $APP_USER --no-create-home --home /usr/share/nginx --gecos "app user" --shell /bin/false --uid $APP_UID $APP_USER
id $APP_USER

echo "Prepare file and dir"
mkdir -p /var/run/nginx
cp -vrf /src/index.html /usr/share/nginx/html/index.html
cp -vrf /src/nginx.conf /etc/nginx/nginx.conf
cp -vrf /src/default.conf /etc/nginx/conf.d/default.conf

chown -vR $APP_UID:$APP_GID /var/cache/nginx
chown -vR $APP_UID:$APP_GID /etc/nginx
chown -vR $APP_UID:$APP_GID /usr/share/nginx /var/run/nginx
chown -vR $APP_UID:$APP_GID /docker-entrypoint.sh
chown -vR $APP_UID:$APP_GID /docker-entrypoint.d
