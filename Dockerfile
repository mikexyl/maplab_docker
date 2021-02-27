FROM ros:kinetic-perception

RUN rm -rf etc/apt/sources.list.d/ros* && sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
ENV UBUNTU_VERSION=xenial

ENV ROS_VERSION=kinetic

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

# RUN pip install numpy==1.9.3 scipy matplotlib

RUN apt install vim -y

RUN apt install libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev -y

RUN apt install software-properties-common -y
#RUN apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE &&\
       #add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u &&\
        #apt-get install librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg  -y

RUN apt install ros-$ROS_VERSION-diagnostics -y

RUN apt install ros-$ROS_VERSION-rgbd-launch -y

RUN apt install ros-$ROS_VERSION-mavros-msgs -y

RUN apt install ros-$ROS_VERSION-rviz ros-${ROS_VERSION}-rqt -y

RUN apt install ros-$ROS_VERSION-geometry -y
RUN apt install ros-$ROS_VERSION-desktop-full "ros-$ROS_VERSION-tf2-*" "ros-$ROS_VERSION-camera-info-manager*" --yes
RUN apt install autotools-dev ccache doxygen dh-autoreconf git liblapack-dev libblas-dev libgtest-dev libreadline-dev libssh2-1-dev pylint clang-format python-autopep8 python-catkin-tools python-pip python-git python-setuptools python-termcolor python-wstool libatlas3-base --yes

# add user
ARG myuser
ARG USERNAME=$myuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
RUN usermod -a -G dialout $myuser

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt update && apt install python-tk -y

RUN apt-get update && apt-get install -y \
    mesa-utils && \
    rm -rf /var/lib/apt/lists/*
RUN chsh -s /bin/bash lxy && \
  yes lxy19961002 | passwd lxy
ENV HOME /home/lxy
RUN apt update && apt install openssh-server -y && touch /etc/ssh/sshd_config_test_clion && ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_test_clion \
  && mkdir /run/sshd

WORKDIR ${HOME}/Workspace/mrslam/maplab_ws/
ENTRYPOINT [ "/ros_entrypoint.sh" ]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]

