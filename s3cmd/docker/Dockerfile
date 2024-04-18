FROM alpine:3.19

RUN apk upgrade --no-cache && apk add --no-cache ca-certificates s3cmd

ENTRYPOINT [ "s3cmd" ]
CMD ["--help"]
