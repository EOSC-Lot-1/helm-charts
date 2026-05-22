# vim: set syntax=dockerfile:

FROM alpine:3.20

RUN apk update \
  && apk add --no-cache tzdata logrotate 

# Use a variant of crond that can be run as non-root user: https://github.com/aptible/supercronic
# see also https://github.com/aptible/supercronic/releases
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.30/supercronic-linux-amd64 \
  SUPERCRONIC_SHA1SUM=9f27ad28c5c57cd133325b2a66bba69ba2235799

RUN  wget "${SUPERCRONIC_URL}" -q -O /usr/local/bin/supercronic \
  && echo "${SUPERCRONIC_SHA1SUM}  /usr/local/bin/supercronic" | sha1sum -c - \
  && chmod a+x /usr/local/bin/supercronic

RUN addgroup -g 1000 logrotate \
  && adduser -D -G logrotate -u 1000 -h /var/lib/logrotate logrotate

COPY ./logrotate.conf /etc/
COPY ./logrotate.d/ /etc/logrotate.d/

COPY ./docker-entrypoint.sh /

VOLUME [ "/var/log/" ]

ENV TZ="Europe/Athens" \
  CRON_SCHEDULE="15 */3 * * * * *"

USER logrotate
ENTRYPOINT [ "/docker-entrypoint.sh" ]
