FROM alpine:3.12.3

LABEL org.opencontainers.image.title="Dockerfile Sample"
# https://github.com/opencontainers/image-spec/blob/master/annotations.md#pre-defined-annotation-keys

RUN mkdir /usr/share/sample_app
WORKDIR /usr/share/sample_app
# COPY from_path to_container_path

ENV HELLO_ENV_VAR="Hello from container"

EXPOSE 8080
USER 10001

ENTRYPOINT ["sh", "-c", "echo $HELLO_ENV_VAR in $PWD"]
