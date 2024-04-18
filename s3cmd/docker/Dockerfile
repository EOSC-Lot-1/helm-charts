FROM alpine:3.19

# note: gpg-agent is not really needed, but gpg complains if agent not running
RUN apk upgrade --no-cache && \
  apk add --no-cache ca-certificates s3cmd gpg gpg-agent

ENTRYPOINT [ "s3cmd" ]
CMD [ "--help" ]
