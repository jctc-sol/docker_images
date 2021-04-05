## Summary
---
Leverage Nvidia Container Toolkit, Docker and Nvidia CUDA+CuDnn Docker base image to create a Docker image recipe for Conda + Pytorch with Cuda development environment for deep learning.


## Mac dual Partition & Ubuntu install
---
Physical machine is an old iMac with ~400GB partitioned hard drive space dedicated for a clean Linux OS environment. Doing this was relatively straight forward and involved the following steps:

1. creating a new partition (and allocate a size for the partition) via the OSX disk utility manager
2. downloading a Linux version (Ubuntu 18.04 LTS was used) and etch it on to an USB disk to create a boot disk
3. boot up the iMac while press "Alt" key to select booting from the Ubuntu boot disk
4. follow the guided steps of the Ubuntu installation process

For more detail there are plenty of guides available such as this one: https://www.howtogeek.com/187410/how-to-install-and-dual-boot-linux-on-a-mac/


## eGPU & Nvidia Driver installation
---
With a fresh Ubuntu installation, the Linux system usually do a very good job at detecting the device & picking the right drivers. The following steps were used to setup the driver:

1. check if all GPU devices are detected by system
```
hwinfo --gfxcard --short
sudo lshw -C display
```

2. install Nvidia driver (CLI method was opted here)
```
apt search nvidia-driver
apt-cache search nvidia-driver
```

3. updating/installing all security & updates
```
sudo apt update
sudo apt upgrade
```

4. install Nvidia device driver & reboot
```
sudo apt install nvidia-driver-460
sudo reboot
```

5. verify that all GPU devices are detected
`nvidia-smi`

(Source: https://www.cyberciti.biz/faq/ubuntu-linux-install-nvidia-driver-latest-proprietary-driver/)


## Docker & Nvidia Container Toolkit Installation
---
1. install Docker-CE
```
curl https://get.docker.com | sh && sudo systemctl --now enable docker
```

2. setup NVIDIA container toolkit
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

3. test CUDA container (result should show similar output as running `nvidia-smi` command locally)
```
sudo docker run --rm --gpus nvidia/cuda:11.0-base nvidia-smi
```

(Source: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian)


# Docker Commands
```
# start the docker container:
#   -d - in detached mode (this frees the current session)
#   --runtime=nvidia - use nvidia runtime
#   --gpus all - expose all GPU devices to Nvidia Container Toolkit
#   --name - container name
#   -v - absolute mount volume path
#   -p 8888:8888 - map host port 8888 to container port 8888 (for Jupyter)
#   -p 6006:6006 - map host port 6006 to container port 6006 (for tensorboard)
docker run --runtime=nvidia -d --gpus all --name [ContainerName] -v $PWD/projects:/projects -p 8888:8888 -p 6006:6006 [DockerImageName]

# display the login token for the jupyter notebook session
docker exec [ContainerName] jupyter notebook list

```

Grab the token as displayed in the terminal and login via `localhost://8888` in a browser

