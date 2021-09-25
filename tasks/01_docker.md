# Docker

The goal of the document is to practice the most important Docker commands.

Docker cli is shipped together with helper docs, that could be displayed via `--help` parameter appended to any command. For example: `docker --help` or `docker run --help`.

## Steps

1. [Install docker](https://docs.docker.com/get-docker/)

2. Pull image

    ```sh
      docker pull nginx:1.19.6-alpine

      # get images
      docker images
    ```

    [Official docker-pull doc](https://docs.docker.com/engine/reference/commandline/pull/)

3. Run containers

    If image available in local cache - docker run container from it. If requested iamge is not available in local cache - docker pulls it:

    ```sh
      # local cache
      docker run -dp 8080:80 nginx:1.19.6-alpine

      # get running containters
      docker ps

      # pull first
      docker run -dp 8081:80 nginx:1.18.0-alpine

      # run interactive container
      docker run -it --rm alpine:3.12.3

      # mount directory into container
      docker run -itv "$(pwd):/local_dir_in_docker" --rm alpine:3.12.3
      # run next command in container and it should list content of the directory, where you were before starting container
      ls -la /local_dir_in_docker
    ```

    [Official docker-run doc](https://docs.docker.com/engine/reference/run/)

4. Build image

    Docker can build image from local file or from url:

    ```sh
      docker build -t sample-app:test https://gist.githubusercontent.com/v1r7u/31a4eff2a02792d4c9917b9f2d8d46f6/raw/2df4ddd8603e3d73c100f7a1e53b157050d65886/Dockerfile
    ```

    [Official docker-build doc](https://docs.docker.com/engine/reference/commandline/build/)

5. List images, list container

    ```sh
      # lists all images
      docker images

      # filter images nginx*
      docker images nginx*

      # list running container
      docker ps

      # list all containers
      docker ps --all
    ```

    Filtering docker images with wildcard [could be tricky](https://kliushnikov.medium.com/filtering-docker-images-5eb5aee358df). Official [docker-images](https://docs.docker.com/engine/reference/commandline/images/) and [docker-ps](https://docs.docker.com/engine/reference/commandline/ps/) docs.

6. Open shell or execute a command in a running container; get logs

    ```sh
      # docker logs {container_name/container_id}
      # NOTE: container_id could be just a first few characters, that uniquely identify a container. For example:
      docker logs 2aba

      # docker exec --interactive --tty {container_name/container_id} {command}
      docker exec -it 2aba /bin/sh
    ```

    [Official docker-exec doc](https://docs.docker.com/engine/reference/commandline/exec/)

7. Copy file to/from container

    ```sh
      # copy to container
      echo "temp" > ./temp_file
      docker cp ./temp_file 2aba:/temp_file

      # verify file in container
      docker exec -it 2aba /bin/sh
      cat /temp_file
      exit

      # copy from container
      rm ./temp_file
      docker container cp 2aba:/temp_file ./temp_file
      cat ./temp_file
    ```

    [Official docker-cp doc](https://docs.docker.com/engine/reference/commandline/container_cp/)

8. Stop and remove container

    ```sh
      # stop/remove running container
      # docker stop {container_name/container_id}
      # docker rm {container_name/container_id}
      docker stop 2aba
      docker rm 2aba

      # or stop & remove:
      docker rm -f 2aba
    ```

    Official [docker-stop](https://docs.docker.com/engine/reference/commandline/stop/) and [docker-rm](https://docs.docker.com/engine/reference/commandline/rm/) docs.

9. Cleanup images and containers

    ```sh
      # docker rmi {image_name/image_id}
      # NOTE: image_id could be just a first few characters, that uniquely identify an image. For example:
      docker rmi 44b

      # remove all stopped containers
      docker container prune

      # remove all dangling images (do not have tags). Often it's intermediate images generated during build process
      docker image prune

      # remove ALL unused images
      docker image prune --all
    ```

    Official [docker-rmi](https://docs.docker.com/engine/reference/commandline/rmi/), [docker-image-prune](https://docs.docker.com/engine/reference/commandline/image_prune/) and [docker-container-prune](https://docs.docker.com/engine/reference/commandline/container_prune/) docs.

10. (optional) [Detailed docker-starter guide](https://docs.docker.com/get-started/) on official website

11. (optional) Learn [Docker Compose](https://docs.docker.com/compose/) via [Getting Started tutorial](https://docs.docker.com/compose/gettingstarted/) to run several container images together.
