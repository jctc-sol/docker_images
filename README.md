# Images

The docker image files for various workflows are provided in this repo:

### base: 
Builds a base docker image with Jupyter + basic datascience packages, including:
	- tqdm>=4.32.1
	- numpy>=1.16.3
	- scipy>=1.3.0
	- pandas>=0.24.2
	- seaborn>=0.9.0
	- matplotlib>=3.1.0
	- scikit-learn>=0.21.2
	- scikit-image>=0.15.0
	- feather-format>=0.4.0
	- pillow>=6.1.0
	- python-snappy
	- avro-python3>=1.9.0
	- fastavro

The images exposes ports 8888 (for Jupyter) and 6006 (for Tensorboard) and mounts volume /projects.


# Docker Commands

Basic docker commands to build, push, you docker image and start your docker container.

```
#!/bin/sh

# build docker image
docker image build --file Dockerfile.txt --tag [DockerImageName] .

# login into docker hub
docker login --username=[YourDockerHubUserName]

# tag your image
docker tag [ImageId] [YourDockerHubName]/[ImageName]:[TAG]

# push your image to docker hub
docker push [YourDockerHubName]/[ImageName]

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