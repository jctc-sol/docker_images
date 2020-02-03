## Summary

This image builds on top of the base-ds image hosted at `jctc/ds-base:latest` on DockerHub, which is a Jupyternotebook local server with exposes ports 8888 (for Jupyter) and 6006 (for Tensorboard) and mounts volume /projects. The additional libraries installed on top are listed under requirements.txt.

# Docker Commands

```
# start the docker container:
#   -d - in detached mode (this frees the current session)
#   --name - container name
#   -v - absolute mount volume path
#   -p 8888:8888 - map host port 8888 to container port 8888 (for Jupyter)
#   -p 6006:6006 - map host port 6006 to container port 6006 (for tensorboard)
docker run -d --name [ContainerName] -v $PWD/projects:/projects -p 8000:8888 -p 6000:6006 [DockerImageName]

# display the login token for the jupyter notebook session
docker exec [ContainerName] jupyter notebook list

```

Grab the token as displayed in the terminal and login via `localhost://8000` (if you mapped 8000 locally to 8888 as instructed above)

