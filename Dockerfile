# Image officielle debian stretch backport
FROM debian:stretch-backports
MAINTAINER Mathieu GERAULT <mathieu.gerault@gmail.com>
LABEL Description="Debian stretch de base"

# Mode interactif enlevé
ENV DEBIAN_FRONTEND noninteractive

# Mise a jour  du systeme
RUN apt-get update && apt-get install -y apt-utils && apt-get -y -q upgrade && apt-get -y -q dist-upgrade

# Installation des utilitaires principaux
# libltdl7 -> permet de faire fonctionner la commande docker dans le conteneur docker ...
RUN apt-get install -y procps \
	&& apt-get install -y vim \
	&& apt-get install -y less \
	&& apt-get install -y curl \
	&& apt-get install -y libltdl7

# Locales
RUN apt-get install -y locales locales-all && update-locale LANG=fr_FR.UTF-8

ENV LC_ALL fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8

# Timezone
RUN echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninterative tzdata

# Copie des fichiers de conf
COPY ./conf_files/bashrc /root/.bashrc
COPY ./conf_files/vimrc /root/.vimrc

# Repertoire de travail par defaut
WORKDIR /root

#CMD [ "/bin/bash" ]
