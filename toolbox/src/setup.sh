#!/bin/sh

APP_GID=1000
APP_UID=1000
APP_USER=alpine

echo "Pre-setup file and dir..."
mkdir -vp /entrypoint.d/
cp -vrf /src/entrypoint.sh /entrypoint.sh
cp -vrf /src/entrypoint.d /

echo "Add User & Group"
addgroup -g $APP_GID $APP_USER

adduser -D \
  -G alpine \
  -u $APP_UID \
  -h /home/$APP_USER \
  -s /bin/sh \
  $APP_USER

id $APP_USER

chown -vR $APP_UID:0 /entrypoint.d
chown -vR $APP_UID:0 /entrypoint.sh

apk update && apk add --no-cache netcat-openbsd curl
rm -vrf /var/cache/apt/*