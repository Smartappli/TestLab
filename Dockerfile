FROM ubuntu:18.04

RUN apt-get update \
      && apt-get install -y software-properties-common debconf \
      && apt-add-repository -y ppa:webupd8team/java \
      && apt-get purge --auto-remove -y \
      && apt-get update \
      && echo oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
      && apt-get install -y oracle-java8-installer oracle-java8-set-default \
      && apt install -y wget build-essential 
  
RUN wget -q -O - https://github.com/antirez/redis/archive/4.0.10.tar.gz | tar -xzf - -C /usr/local \
  && cd /usr/local/redis-4.0.10 \
  && make V=1 \
  && make install 
  
RUN wget -q -O - http://apache.cu.be/kafka/1.1.0/kafka_2.11-1.1.0.tgz | tar -xvzf - -C /usr/local \
  && cd /usr/local/kafka_2.11-1.1.0 \
  && bin/zookeeper-server-start.sh config/zookeeper.properties \
  #&& cp config/server.properties config/server-1.properties \
  #&& cp config/server.properties config/server-2.properties \
  && bin/kafka-server-start.sh config/server.properties \
  #&& bin/kafka-server-start.sh config/server-1.properties \& \
  #&& bin/kafka-server-start.sh config/server-2.properties \&
