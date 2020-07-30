FROM ros:melodic-perception-bionic

ENV UBUNTU_VERSION=bionic

ENV ROS_VERSION=melodic

RUN apt update

RUN apt install autotools-dev ccache doxygen dh-autoreconf git liblapack-dev libblas-dev libgtest-dev libreadline-dev libssh2-1-dev pylint clang-format python-autopep8 python-catkin-tools python-pip python-git python-setuptools python-termcolor python-wstool libatlas3-base --yes

RUN pip install requests

RUN apt install -y ccache &&\
  echo 'export PATH="/usr/lib/ccache:$PATH"' | tee -a ~/.bashrc

ENV PATH="/usr/lib/ccache:$PATH"

RUN ccache --max-size=10G

RUN apt install wget -y

RUN apt install libv4l-dev -y

RUN apt install virtualenv -y

RUN apt install bison byacc flex -y

RUN pip install numpy scipy matplotlib python-igraph

RUN apt install vim -y