#!/bin/bash

echo "Build de la debian custo"
docker build -t gerault/docker-debian-stretch-backports . --pull
