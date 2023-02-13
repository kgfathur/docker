#!/bin/bash

APP_GID=1001
APP_UID=1001
APP_USER=app

echo "Add User & Group"
addgroup --gid $APP_GID $APP_USER
adduser --disabled-login --ingroup $APP_USER --no-create-home --home /usr/share/nginx --gecos "app user" --shell /bin/false --uid $APP_UID $APP_USER
id $APP_USER

ln -vsf /dev/stdout /var/log/nginx/access.log
ln -vsf /dev/stderr /var/log/nginx/error.log

echo "Prepare file and dir"
rm -vrf /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
mkdir -vp /var/run/nginx /tmp/nginx
cp -vrf /src/index.html /usr/share/nginx/html/index.html
cp -vrf /src/nginx.conf /etc/nginx/nginx.conf
cp -vrf /src/default.conf /etc/nginx/conf.d/default.conf

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
chown -vR $APP_UID:$APP_GID /usr/share/nginx
chown -vR $APP_UID:$APP_GID /docker-entrypoint.sh
chown -vR $APP_UID:$APP_GID /docker-entrypoint.d
