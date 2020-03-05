#!/bin/bash

# Bash wrapper for the build environment

# https://stackoverflow.com/a/246128
# Get the directory from where the script is called for further path resolution
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
#

# Copy the files from the NGINX Docker container to the local repository
echo 
docker build -t nginx_production "${DIR}/../docker"
id=$(docker run --rm --name nginx_cp -p 80:80 -d nginx_production)
mkdir -p ${DIR}/../shared/etc/
mkdir -p ${DIR}/../shared/usr/share/nginx/
docker cp $id:/etc/nginx/ ${DIR}/../shared/etc/
docker cp $id:/usr/share/nginx/html ${DIR}/../shared/usr/share/nginx/
docker stop $id

# From here, we can continue with configuring the files