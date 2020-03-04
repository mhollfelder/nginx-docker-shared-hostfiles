#/bin/bash

# Copy the files from the NGINX Docker container to the local repository
cd ../shared
docker build -t nginx_production ../docker
id=$(docker run --rm --name nginx_cp -p 80:80 -d nginx_production)
mkdir -p ./etc/nginx
mkdir -p ./src/usr/share/nginx/html
docker cp $id:/etc/nginx ./etc/nginx
docker cp $id:/usr/share/nginx/html/ ./src/usr/share/nginx/html
docker stop $id