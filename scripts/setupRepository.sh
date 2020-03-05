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
echo "Starting to create Docker container or refreshing it"
docker build -t nginx_production "${DIR}/../docker"
id=$(docker run --rm --name nginx_cp -p 80:80 -d nginx_production)
echo "Docker ID is $(id)"
echo "Trying to create backup - NO CHECK WILL BE DONE"
mkdir -p ${DIR}/../shared/backup
zip -r backup-$(date +%F).zip ${DIR}/../shared/backup
echo "Creating shared folder structure structure..."
mkdir -p ${DIR}/../shared/etc/
mkdir -p ${DIR}/../shared/usr/share/nginx/
echo "Copying files..."
docker cp $id:/etc/nginx/ ${DIR}/../shared/etc/
docker cp $id:/usr/share/nginx/html ${DIR}/../shared/usr/share/nginx/
echo "Stopping container"
docker stop $id
echo "Check shared folder to see whether all files could be copied!"
echo "Especially, check the shared/etc* and /shared/usr/* folders that NGINX expected files EXIST."
echo "WARNING: On Windows, symlinks cannot be copied and cp will abort - copy files manually!"

# From here, we can continue with configuring the files