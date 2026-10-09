FROM alpine:3.24

# note: gpg-agent is not really needed, but gpg complains if agent not running
# note: coreutils is added for providing the richer `date` command
RUN apk upgrade --no-cache && \
  apk add --no-cache ca-certificates gpg gpg-agent coreutils s3cmd

ENTRYPOINT [ "s3cmd" ]
CMD [ "--help" ]
