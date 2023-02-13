FROM nginx:1.22

LABEL maintainer="kgfathur" \
      name="nginx-certbot" \
      description="NGINX image with certbot installed"

COPY ./src /src

RUN chmod +x /src/setup.sh \
  && bash /src/setup.sh \
  && rm -vrf /src

EXPOSE 8080
USER 1001