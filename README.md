# Setting up NGINX with Docker

This repository starts an NGINX instance and copies the latest `html` and `config` files to the cloned repository.
Sounds simple, but it took quite a time of online research plus trial and error.

```console
NGINX/                      # The root folder './'
┣ docker/                   # All Docker related files
┃ ┣ docker-compose.yml      # Orchestrate container and additional options, e.g. volumes with host mapping
┃ ┗ Dockerfile              # Create a single container
┣ docs/                     # Additional documentation
┣ scripts/                  # Setting up the basics - scripts to be used with Bash
┃ ┗ setupRepository.sh      # Setting up the `./shared` folder
┣ shared/                   # The config/web-page NGINX container (shared with host)
┣ .gitignore                # Files which should be ignored for Git
┗ README.md                 # This file
```

## Introduction

All the files under `./shared` will not be checked out by Git - they are ignored by default.
Hence, the copied files will not be tracked as they might be dependent on the NGINX version.

Please follow the below instructions to setup the base minimum as pulling this repo creates the skeleton only.

## Setup of the shared directories

ALL FILES IN `./shared` WILL BE DELETED

If you would like to start from a bare minimum, execute the following part and modify the files AFTERWARDS.
Otherwise, you will overwrite all your files in `./shared` and no CHECKED backup will be stored.

You start with a clean bare minimum of NGINX here as stated above.
First of all, execute the following commands from the repository root folder `./` in a Bash console:

```console
$ cd ./scripts
$ # Make the script executable (Linux only)
$ chmod +x setupRepository.sh
$ # Execute the script
$ ./setupRespository.sh
```

Please check the code in the `./scripts/setupRepository.sh` if you are interested in more details.

The script will start a Docker container with the latest release of NGINX from Docker Hub to prepare a basic fundament.
Consecutively, it will create local folders in the `./shared` directory for config `./etc/*` and webpage `./usr/*` files.

In a nutshell, we separate the bare minimum NGINX container from configuration via the host.

Please note that you should NOT put any SECRET information such as a database root password in any '.txt' (human readable) files.
This is especially important if you plan to use such setup for PRODUCTIVE deployment.

## Setup NGINX

Please make sure that you change to the `./docker` folder before executing anything below.
Here, it is assumed that you are executing any command from the root directory of the repository `./`.

```console
$ cd ./docker
$ # Use Docker Compose for executing the commands
$ docker-compose up
$ # NGINX will be parsing via standard console
```

Continue as per your requirements, you can follow any reconfiguration guide online.

## Links
* https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/
* https://www.docker.com/blog/tips-for-deploying-nginx-official-image-with-docker/
* https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/
* http://geekyplatypus.com/dockerise-your-php-application-with-nginx-and-php7-fpm/
* https://www.netnea.com/cms/nginx-tutorial-2_minimal-nginx-configuration/