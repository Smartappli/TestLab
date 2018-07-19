FROM ubuntu:18.04

RUN apt update \
  && apt upgrade -y \
  && apt install -y wget build-essential 
  
RUN wget -q -O - https://github.com/antirez/redis/archive/4.0.10.tar.gz | tar -xzf - -C /usr/local \
  && cd /usr/local/redis-4.0.10 \
  && make V=1 \
  && make install 
  
RUN wget -q -O - https://www.apache.org/dyn/closer.cgi?path=/kafka/1.1.0/kafka_2.11-1.1.0.tgz | tar -xzf - -C /usr/local \
  && cd /usr/local/kafka_2.11-1.1.0 \
  && bin/zookeeper-server-start.sh config/zookeeper.properties \
  && cp config/server.properties config/server-1.properties \
  && cp config/server.properties config/server-2.properties \
  && bin/kafka-server-start.sh config/server.properties
