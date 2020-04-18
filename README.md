# docker-sbt
In one scenario, I had to create an SBT container for scala code compilation, and publishing images through SBT's `docker native packager` pluguin.
So to facilitate me in that scenario, I created a docker image from official `docker` image which supports docker in docker use-case. While creating a docker container I am mounting `/var/run/docker.sock` inside container so that the docker service will create sibling containers or images with host machine's docker service. You can read further about it [here](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

# Build Image:
Build this image using following command:
```shell
docker build --build-arg SCALA_VERSION=2.12.10 --build-arg SBT_VERSION=1.2.8 -t docker-sbt .
```

# Build Code with Docker Container:
Mount your `./code` inside docker container and run SBT build commands through `sh` shell.
```
docker run -it --rm -v $(pwd)/code:/code -v /var/run/docker.sock:/var/run/docker.sock docker-sbt sh -c 'cd /code; sbt update; sbt "project data-service-deploy" "docker:publishLocal"'
```

Upon successful execution, a newly published image can be seen in the output of `docker images`.
