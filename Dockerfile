FROM ros:melodic-perception-bionic

ENV UBUNTU_VERSION=bionic

ENV ROS_VERSION=melodic

RUN apt install autotools-dev ccache doxygen dh-autoreconf git liblapack-dev libblas-dev libgtest-dev libreadline-dev libssh2-1-dev pylint clang-format-3.8 python-autopep8 python-catkin-tools python-pip python-git python-setuptools python-termcolor python-wstool libatlas3-base --yes

RUN pip install requests

RUN apt install -y ccache &&\
  echo 'export PATH="/usr/lib/ccache:$PATH"' | tee -a ~/.bashrc &&\
  source ~/.bashrc && echo $PATH &&\  
  ccache --max-size=10G

