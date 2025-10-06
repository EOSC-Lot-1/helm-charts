FROM golang:1.22 AS builder

WORKDIR /app

COPY . .

# Build a statically linked binary
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o echo-server echo-server.go


FROM scratch

COPY --from=builder /app/echo-server /echo-server

EXPOSE 8080

ENTRYPOINT ["/echo-server"]
