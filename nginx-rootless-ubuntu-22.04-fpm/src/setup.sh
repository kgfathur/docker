#!/bin/bash

APP_GID=1000
APP_UID=1000
APP_USER=nginx
OS_CODENAME=$(grep -Po 'VERSION_CODENAME=\K\w+' /etc/os-release)

echo "Pre-setup file and dir..."
mkdir -vp /entrypoint.d/ /usr/share/nginx/html
cp -vrf /src/entrypoint.sh /entrypoint.sh
cp -vrf /src/entrypoint.d /

chown -vR $APP_UID:0 /usr/share/nginx

echo "Add User & Group"
groupadd --gid $APP_GID $APP_USER

useradd \
  --gid $APP_GID \
  --uid $APP_UID \
  --no-create-home \
  --home /usr/share/nginx \
  --shell /bin/false \
  $APP_USER

id $APP_USER

echo "Setup: repo"
apt-get update
apt-get install -y --no-install-recommends curl gnupg2 ca-certificates ubuntu-keyring

APT_KEYRING_PATH=/etc/apt/trusted.gpg.d/nginx-archive-keyring.gpg
curl -s https://nginx.org/keys/nginx_signing.key | gpg  -v --yes --dearmor -o ${APT_KEYRING_PATH}
gpg --dry-run --quiet --no-keyring --import --import-options import-show ${APT_KEYRING_PATH}

echo "deb [signed-by=${APT_KEYRING_PATH}] \
http://nginx.org/packages/ubuntu ${OS_CODENAME} nginx" \
  | tee /etc/apt/sources.list.d/nginx.list

apt-get update
apt-get install -y --no-install-recommends nginx=${NGINX_VERSION}*

DEBIAN_FRONTEND=noninteractive TZ=Asia/Jakarta apt-get install -y --no-install-recommends tzdata
echo "Asia/Jakarta" | tee /etc/timezone

apt-get install -y --no-install-recommends php8.1-fpm
update-alternatives --install /usr/bin/php-fpm php-fpm /usr/sbin/php-fpm8.1 0

apt-get clean autoclean
apt-get autoremove --yes

rm -vrf /var/lib/{apt,cache,log}/
rm -vrf /var/log/{apt,*.log}

ln -vsf /dev/stdout /var/log/nginx/access.log
ln -vsf /dev/stderr /var/log/nginx/error.log

echo "Prepare file and dir"
mkdir -vp /var/run/nginx /tmp/nginx
cp -vrf /src/index.html /usr/share/nginx/html/index.html
cp -vrf /src/index.php /usr/share/nginx/html/index.php
cp -vrf /src/nginx.conf /etc/nginx/nginx.conf
cp -vrf /src/default.conf /etc/nginx/conf.d/default.conf

cp -vrf /src/zzz-docker.conf /etc/php/8.1/fpm/pool.d/zzz-docker.conf

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

mkdir -v /run/php
mkdir -v /var/log/php

chown -vR $APP_UID:0 /etc/php
chown -vR $APP_UID:0 /run/php
chown -vR $APP_UID:0 /var/log/php
chown -vR $APP_UID:0 /usr/share/nginx/html
chmod -vR g+w /etc/php
chmod -vR g+w /run/php
chmod -vR g+w /var/log/php

chown -vR $APP_UID:0 /entrypoint.d
chmod -vR 750 /entrypoint.d/{*.sh,*.envsh} || echo -n
chown -vR $APP_UID:0 /entrypoint.sh
chmod -vR 750 /entrypoint.sh
