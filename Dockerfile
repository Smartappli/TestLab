FROM ubuntu:18.04

RUN apt update \
  && apt upgrade -y \
  && apt install -y wget build-essential \
  && wget -q -O - https://github.com/antirez/redis/archive/4.0.10.tar.gz | tar -xzf - -C /usr/local \
  && cd /usr/local/4.0.10 \
  && make V=1 \
  && make install 
