#!/bin/bash

echo "Build de la debian custo"
docker build -t gerault/debian-stretch-backports .
