# vim: set syntax=dockerfile:

FROM alpine:3.20

RUN apk update \
  && apk add --no-cache rsyslog rsyslog-tls rsyslog-relp rsyslog-mmpstrucdata rsyslog-elasticsearch

RUN addgroup -g 1000 rsyslog \
  && adduser -D -G rsyslog -u 1000 -h /var/lib/rsyslog rsyslog

COPY rsyslog.conf /etc/rsyslog.conf

VOLUME [ "/var/log/" ]

USER rsyslog
CMD ["rsyslogd", "-n", "-i/var/lib/rsyslog/rsyslog.pid"]
