FROM rockylinux:9.1

LABEL maintainer="kgfathur" \
      name="nginx-rootless" \
      description="NGINX image with rootless priviledge based on Rocky Linux Minimal"

COPY ./src /src

RUN chmod +x /src/setup.sh \
  && bash /src/setup.sh \
  && rm -vrf /src

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080

STOPSIGNAL SIGQUIT

USER 1001

CMD ["nginx", "-g", "daemon off;"]