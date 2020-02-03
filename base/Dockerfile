# -----------------------------------------------------------------
# compiler image
# -----------------------------------------------------------------
FROM python:3.7-slim AS compile-image

RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential \
 && apt-get install -y gcc g++ libsnappy-dev

# install python in virtualenv
RUN python -m venv /opt/venv
# make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

# use layer caching to ensure requirements.txt does not become stale
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install --no-cache-dir jupyter \
    && pip install -r requirements.txt


# -----------------------------------------------------------------
# build image
# -----------------------------------------------------------------
FROM python:3.7-slim AS build-image

RUN apt-get update \
 && apt-get install -y gcc g++ libsnappy-dev \
 && apt-get install vim -y

# copy files compiled in compile-image over
COPY --from=compile-image /opt/venv /opt/venv

# make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

# allocate port 8888 for Jupyter Notebook
# allocate port 6006 for tensorboard
EXPOSE 8888 6006

# mount volume
VOLUME /projects

# set cwd
WORKDIR /projects
