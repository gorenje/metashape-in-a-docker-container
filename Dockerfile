FROM ubuntu:18.04

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install --no-install-recommends -y \
  binutils         \
  emacs            \
  less             \
  libglib2.0       \
  libglu1          \
  libgomp1         \
  libgssapi-krb5-2 \
  libgtk2.0-0      \
  libquadmath0     \
  mesa-utils       \
  qt5-default      \
  strace           \
  wget

WORKDIR /root

RUN wget -q --no-check-certificate https://s3-eu-west-1.amazonaws.com/download.agisoft.com/metashape_1_7_2_amd64.tar.gz -O metashape_1_7_2_amd64.tar.gz

RUN tar xfz metashape_1_7_2_amd64.tar.gz

ENV DISPLAY=host.docker.internal:0

ENTRYPOINT /bin/bash
