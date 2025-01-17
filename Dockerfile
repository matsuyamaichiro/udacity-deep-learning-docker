# FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
FROM ubuntu:18.04

ARG CONTAINER_USER
ARG HOST_USER_GID
ARG HOST_USER_UID
ARG TIMEZONE

WORKDIR /tmp

# Disable interactive configuration
ENV DEBIAN_FRONTEND=noninteractive

# Setup the host's timezone
RUN apt-get update && \
    ln -sf /usr/share/zoneinfo/${TIMEZONE:?} /etc/localtime && \
    apt-get install -y tzdata

# Create user
RUN groupadd --gid ${HOST_USER_GID:?} ${CONTAINER_USER:?} && \
    useradd \
        --create-home \
        --shell /bin/bash \
        --uid ${HOST_USER_UID:?} \
        --gid ${CONTAINER_USER:?} \
        --groups 27 \
        ${CONTAINER_USER:?} && \
    echo "export PS1=\"(container) \$PS1\"" >> \
        /home/${CONTAINER_USER:?}/.bashrc && \
    echo "export PS1=\"(container) \$PS1\"" >> /root/.bashrc && \
    apt-get update && \
    apt-get install -y sudo && \
    echo "${CONTAINER_USER:?} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get update && apt-get install -y curl
RUN curl -OL https://repo.anaconda.com/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh
RUN chmod 755 Miniconda3-4.7.12.1-Linux-x86_64.sh
RUN ./Miniconda3-4.7.12.1-Linux-x86_64.sh -b -p /opt/miniconda
RUN ln -s /opt/miniconda/bin/conda /usr/local/bin/conda
RUN su - user -c "conda init bash"
RUN conda install jupyter notebook
RUN conda install scipy
RUN conda install pillow==6.2.1
RUN conda install tensorflow-gpu==1.15.0
RUN conda install -c conda-forge moviepy imageio-ffmpeg
RUN conda install matplotlib
RUN conda install pandas
RUN /opt/miniconda/bin/pip install udacity-pa
RUN conda install bokeh
RUN conda install scikit-learn
RUN conda install pytorch-gpu torchvision
RUN apt-get update && apt-get install -y gcc
RUN /opt/miniconda/bin/pip install wandb
COPY notebook /usr/local/bin

# Open CV
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y libgl1-mesa-dev
RUN conda install -c conda-forge opencv

# Efficient Net
RUN conda install -c conda-forge efficientnet-pytorch

WORKDIR /workdir
CMD /bin/bash
