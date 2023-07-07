FROM ubuntu

RUN apt-get update && apt-get install -y netcat curl
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y software-properties-common postgresql-14 postgresql-contrib-14
RUN apt-get install -y sudo
