# vim: set syntax=dockerfile

FROM debian:12-slim

RUN apt-get update && apt-get install -y openssl msmtp mutt

RUN groupadd -g 1000 user1 && useradd -M -u 1000 -g 1000 user1

USER user1
WORKDIR /home/user1
