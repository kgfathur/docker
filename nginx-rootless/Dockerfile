FROM nginx:1.22

LABEL maintainer="kgfathur" \
      name="nginx-rootless" \
      description="NGINX image with rootless priviledge"

COPY ./src /src

RUN chmod +x /src/setup.sh \
  && bash /src/setup.sh \
  && rm -vrf /src

EXPOSE 8080
USER 1001