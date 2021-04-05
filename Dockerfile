# Leverage NVIDIA pre-built docker containers with CUDA & CuDNN
FROM nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu18.04

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y curl \
 && apt-get update && apt-get install -y apt-utils unzip wget

# Install anaconda along with all other data science libraries
RUN wget https://repo.continuum.io/archive/Anaconda3-2020.02-Linux-x86_64.sh \
 && bash Anaconda3-2020.02-Linux-x86_64.sh -b \
 && rm Anaconda3-2020.02-Linux-x86_64.sh

# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH

# configure access to Jupyter
RUN jupyter notebook --generate-config --allow-root

# install pytorch with cuda & tensorboard
RUN pip -q install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html \
 && pip -q install tensorboard

# allocate port 8888 for Jupyter Notebook
# allocate port 6006 for tensorboard
EXPOSE 8888 6006

# mount volume
VOLUME /projects

# set cwd
WORKDIR /projects

# Run startup scripts
COPY ./start.sh /
RUN chmod +x /start.sh
CMD ["/start.sh"]
