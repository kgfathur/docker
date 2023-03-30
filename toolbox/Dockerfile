FROM alpine:3.17

LABEL maintainer="kgfathur" \
      name="toolbox" \
      description="Container Toolbox"

COPY ./src /src

RUN chmod +x /src/setup.sh \
  && sh /src/setup.sh \
  && rm -vrf /src

ENTRYPOINT ["/entrypoint.sh"]

STOPSIGNAL SIGQUIT

USER 1000