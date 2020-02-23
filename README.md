This is a docker image that I used for running projects of the
[Udacity Deep Learning nanodegree](https://www.udacity.com/course/deep-learning-nanodegree--nd101).
It is based on Ubuntu 18.04 and contains all of the necessary dependencies,
such as conda, PyTorch, Jupyter, numpy and etc.

## Prerequisites

* Docker
* [Nvidia Container Toolkit](https://github.com/NVIDIA/nvidia-docker)

## Usage

First, we need to build a Docker image:
* clone this repository and proceed to the root directory of the repository.
* run the [```build```](build) script.

When you need to run code inside the container:
* on the host filesystem, proceed to the directory containing the target source code.
* launch the [```run```](run) script. It will start the container and bring you
  to the ```bash``` session inside the container, with the host's working directory
  mounted as ```/workdir``` inside the container.
* to start Jupyter, enter the ```notebook``` command inside the container's
  ```bash``` session. It will start Jupyter server listening on
  the ```localhost:8888``` address.
* to stop the container, simply exit the container's ```bash``` session.

## Contributing

If you'd like to improve the usability of the container or install new
dependencies inside the docker image, please make a pull request.

## License

MIT
