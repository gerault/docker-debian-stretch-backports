# Official debian stretch backport image
FROM debian:stretch-backports
MAINTAINER Mathieu GERAULT <mathieu.gerault@gmail.com>
LABEL Description="Debian stretch from Mathieu GERAULT"

# Suppress interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Update system and install apt-utils
RUN apt-get update \
	&& apt-get install -y apt-utils \
	&& apt-get -y -q upgrade \
	&& apt-get -y -q dist-upgrade

# Principal tools
# libltdl7 -> needed to make the "docker" command work in the docker container
RUN apt-get install -y procps \
	&& apt-get install -y vim \
	&& apt-get install -y less \
	&& apt-get install -y curl \
	&& apt-get install -y wget \
	&& apt-get install -y python \
	&& apt-get install -y libltdl7

# Locales
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8

RUN apt-get install -y locales locales-all && update-locale LANG=$LANG

# Timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Copy configuration files
COPY ./conf_files/bashrc /root/.bashrc
COPY ./conf_files/vimrc /root/.vimrc

# Default work directory
WORKDIR /root

