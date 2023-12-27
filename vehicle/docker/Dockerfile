FROM ubuntu:20.04

ENV PYTHON_VERSION=3.9
ENV LANG=en_US.UTF-8
ENV ROS_DISTRO=noetic

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install locales -y
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

#RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        wget \
        ca-certificates \
        libjpeg-dev \
        libpng-dev \
        python${PYTHON_VERSION} \
        python${PYTHON_VERSION}-dev \
        python${PYTHON_VERSION}-distutils \
        librdmacm1 \
        libibverbs1 \
        ibverbs-providers
RUN apt install gnupg2 lsb-release -y

RUN apt install keyboard-configuration -y
RUN apt install -y terminator
RUN mkdir -p /root/.config/terminator
RUN touch /root/.config/terminator/config

RUN curl https://getmic.ro | bash;mv micro /usr/local/bin/

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py
RUN apt -y install libopencv-dev libopencv-core-dev python3-opencv

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt update && apt install -y \
  python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

RUN apt update;
RUN apt install python3-vcstool -y
RUN apt install ros-${ROS_DISTRO}-desktop-full -y
RUN apt install gazebo11 ros-${ROS_DISTRO}-gazebo-ros-pkgs -y

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

RUN apt-get update
RUN apt-get install -y python3-wstool python3-rosdep ninja-build stow -y

RUN apt install python3-argcomplete -y
RUN apt install python3-osrf-pycommon python3-catkin-tools -y

RUN git clone https://github.com/ROBOTIS-GIT/robotis_tools.git
RUN cd robotis_tools;chmod +x install_ros_${ROS_DISTRO}.sh;bash install_ros_${ROS_DISTRO}.sh

RUN apt-get install ros-${ROS_DISTRO}-joy ros-${ROS_DISTRO}-teleop-twist-joy \
  ros-${ROS_DISTRO}-teleop-twist-keyboard ros-${ROS_DISTRO}-laser-proc \
  ros-${ROS_DISTRO}-rgbd-launch ros-${ROS_DISTRO}-depthimage-to-laserscan \
  ros-${ROS_DISTRO}-rosserial-arduino ros-${ROS_DISTRO}-rosserial-python \
  ros-${ROS_DISTRO}-rosserial-server ros-${ROS_DISTRO}-rosserial-client \
  ros-${ROS_DISTRO}-rosserial-msgs ros-${ROS_DISTRO}-amcl ros-${ROS_DISTRO}-map-server \
  ros-${ROS_DISTRO}-move-base ros-${ROS_DISTRO}-urdf ros-${ROS_DISTRO}-xacro \
  ros-${ROS_DISTRO}-compressed-image-transport ros-${ROS_DISTRO}-rqt* \
  ros-${ROS_DISTRO}-gmapping ros-${ROS_DISTRO}-navigation ros-${ROS_DISTRO}-interactive-markers -y

RUN apt-get install ros-${ROS_DISTRO}-dynamixel-sdk -y
RUN apt-get install ros-${ROS_DISTRO}-turtlebot3-msgs -y
RUN apt-get install ros-${ROS_DISTRO}-turtlebot3 -y

RUN echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/turtlebot3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc
RUN echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc

RUN mkdir -p ~/turtlebot3_ws/src;cd ~/turtlebot3_ws;wget https://raw.githubusercontent.com/ROBOTIS-GIT/turtlebot3/ros2/turtlebot3.repos;vcs import src < turtlebot3.repos;
RUN cd ~/turtlebot3_ws/src/turtlebot3/turtlebot3_simulations;git checkout ${ROS_DISTRO}-devel
RUN cd ~/turtlebot3_ws/src/turtlebot3/turtlebot3;git checkout ${ROS_DISTRO}-devel
RUN cd ~/turtlebot3_ws/src/turtlebot3/turtlebot3_msgs;git checkout ${ROS_DISTRO}-devel
RUN cd ~/turtlebot3_ws/src/utils/hls_lfcd_lds_driver;git checkout ${ROS_DISTRO}-devel
RUN cd ~/turtlebot3_ws/src/utils/DynamixelSDK;git checkout ${ROS_DISTRO}-devel
RUN cd ~/turtlebot3_ws/src/utils/hls_lfcd_lds_driver;git checkout ${ROS_DISTRO}-devel
RUN . /opt/ros/${ROS_DISTRO}/setup.sh;cd ~/turtlebot3_ws;catkin build

RUN echo "source ~/turtlebot3_ws/devel/setup.bash" >> ~/.bashrc

RUN echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc
# cartographer
#RUN mkdir ~/cartographer_ws;cd ~/cartographer_ws; \
#  wstool init src; \
#  wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall; \
#  wstool update -t src

#RUN cd ~/cartographer_ws; \
#  rosdep init \
#  rosdep update \
#  rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

#RUN cd ~/cartographer_ws;src/cartographer/scripts/install_abseil.sh; \
#  apt-get remove ros-${ROS_DISTRO}-abseil-cpp -y; \
#  catkin_make_isolated --install --use-ninja

#RUN apt install ros-${ROS_DISTRO}-navigation2 -y
#RUN apt install ros-${ROS_DISTRO}-nav2-bringup -y

#RUN cp /root/turtlebot3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/launch/empty_world.launch.py /opt/ros/${ROS_DISTRO}/share/gazebo_ros/launch/empty_world.launch.py


#RUN apt update;
#RUN apt install \
#  ros-${ROS_DISTRO}-ros-control \
#  ros-${ROS_DISTRO}-gazebo-ros-control \
#  ros-${ROS_DISTRO}-joint-state-controller \
#  ros-${ROS_DISTRO}-ros-controllers \
#  ros-${ROS_DISTRO}-effort-controllers \
#  ros-${ROS_DISTRO}-joint-trajectory-controller \
#  ros-${ROS_DISTRO}-moveit* \
#  ros-${ROS_DISTRO}-octomap \
#  ros-${ROS_DISTRO}-object-recognition-* -y
