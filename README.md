# Setting up NGINX with Docker

This repository starts an NGINX instance and copies the latest `html` and `config` files to this repository.
The copied files will not be tracked by Git as they might be dependent on the latest NGINX release.

Please follow the below instructions to setup the base minimum as pulling this repo creates the bare skeleton.

## Setup the shared directories

First of all, change to the folder `./scripts` and execute the following commands from the repository root folder `./`:

```console
cd ./scripts
# Make the script executable
chmod +x setupRepository.sh
# Execute the script
./setupRespository.sh
```

This will start a Docker container with the latest release of NGINX to prepare a shared start.
Moreover, it will create local folders in the `./shared` directory of configuration `./etc/*` and web-page `./usr/*` files.

## Setup NGINX

## Links
* https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/
* https://www.docker.com/blog/tips-for-deploying-nginx-official-image-with-docker/
* https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/
* http://geekyplatypus.com/dockerise-your-php-application-with-nginx-and-php7-fpm/
* https://www.netnea.com/cms/nginx-tutorial-2_minimal-nginx-configuration/