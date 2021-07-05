FROM nvidia/cuda:10.2-base-ubuntu18.04
SHELL [ "/bin/bash", "-c" ]

ARG VERSION="v7.6"
ARG PYTHON_VERSION_TAG=3.8.7
ARG LINK_PYTHON_TO_PYTHON3=1

RUN apt update
#RUN apt-get install wget -y
#RUN apt-get install openjdk-11-jdk -y


RUN set -ex \
  #&& apt update \
  && apt upgrade -y \
  && apt update \
  && apt install -y \
    bzip2 \
    software-properties-common \
    tzdata \
    wget \
  && add-apt-repository -y ppa:graphics-drivers \
  && apt install -y \
    nvidia-opencl-dev \
  && apt-get install openjdk-11-jdk -y \
  && apt-get install -y git \
  && useradd --system folding \
  && mkdir -p /opt/fahclient \
  && wget https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/${VERSION}/latest.tar.bz2 -O /tmp/fahclient.tar.bz2 \
  && tar -xjf /tmp/fahclient.tar.bz2 -C /opt/fahclient --strip-components=1 \
  && wget https://apps.foldingathome.org/GPUs.txt -O /opt/fahclient/GPUs.txt \
  && chown -R folding:folding /opt/fahclient \
  && rm -rf /tmp/fahclient.tar.bz2 \
  && apt remove -y software-properties-common \
  && apt autoremove -y \
  && apt clean autoclean \
  && rm -rf /var/lib/apt/lists/*

COPY --chown=folding:folding entrypoint.sh /opt/fahclient

USER folding
WORKDIR /opt/fahclient

ENV USER "Anonymous"
ENV TEAM "0"
ENV ENABLE_GPU "false"
ENV ENABLE_SMP "true"
ENV POWER "full"

EXPOSE 7396
ENTRYPOINT ["/opt/fahclient/entrypoint.sh"]

CMD [ "/bin/bash" ]


