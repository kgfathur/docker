#!/bin/bash

APP_GID=1001
APP_UID=1001
APP_USER=nginx

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
dnf install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm

cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=https://nginx.org/packages/centos/9/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF

dnf repolist
dnf install nginx certbot -y

ln -vsf /dev/stdout /var/log/nginx/access.log
ln -vsf /dev/stderr /var/log/nginx/error.log

echo "Prepare file and dir"
# rm -vrf /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
mkdir -vp /var/run/nginx /tmp/nginx
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
chown -vR $APP_UID:0 /entrypoint.d
chown -vR $APP_UID:0 /entrypoint.sh

dnf clean all --verbose
