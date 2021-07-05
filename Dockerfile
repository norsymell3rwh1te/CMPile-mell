FROM ubuntu:20.04
USER root
WORKDIR /root
SHELL [ "/bin/bash", "-c" ]
ARG PYTHON_VERSION_TAG=3.8.7
ARG LINK_PYTHON_TO_PYTHON3=1

RUN apt update && apt upgrade -y \
    apt update \
    apt-get install openjdk-11-jdk -y \
    apt-get install -y git \

COPY config.sh /config.sh
RUN ls
RUN chmod +x config.sh
RUN ./config.sh


CMD [ "/bin/bash" ]
