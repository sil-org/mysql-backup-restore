FROM python:3-alpine

ARG GITHUB_REF_NAME=unknown
ARG GITHUB_SHA=unknown
ENV GITHUB_REF_NAME=${GITHUB_REF_NAME}
ENV GITHUB_SHA=${GITHUB_SHA}

RUN <<EOF
  apk update
  apk add --no-cache \
    bash \
    curl \
    mysql-client \
    py3-pip

  curl -sL https://sentry.io/get-cli/ | bash

  pip3 install awscli
EOF

COPY application/ /data/
WORKDIR /data

CMD ["./entrypoint.sh"]
