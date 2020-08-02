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

RUN pip install numpy==1.9.3 scipy matplotlib python-igraph

RUN apt install vim -y

RUN apt install libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev -y

RUN apt install software-properties-common -y
#RUN apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE &&\
       #add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u &&\
        #apt-get install librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg  -y

RUN apt install ros-melodic-diagnostics -y

RUN apt install ros-melodic-rgbd-launch -y

RUN apt install ros-melodic-mavros-msgs -y

RUN apt install ros-melodic-realsense* -y

RUN apt remove ros-melodic-realsense* -y

