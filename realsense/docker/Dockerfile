ARG ROS_DISTRO
FROM osrf/ros:${ROS_DISTRO}-desktop-full

ENV DEBIAN_FRONTEND noninteractive

# RUN apt update && apt install locales -y
# RUN locale-gen en_US en_US.UTF-8
# RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

SHELL ["/bin/bash", "-c"]

#RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt update
RUN apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
      build-essential \
      cmake \
      git

RUN apt-get install ros-humble-gazebo-ros -y

RUN apt install nano -y

RUN apt-get install ros-$ROS_DISTRO-realsense2-camera -y

RUN apt install ros-${ROS_DISTRO}-ament-cmake-clang-format -y

RUN mkdir -p ~/ros2_ws/src
RUN cd ~/ros2_ws/src && \
      git clone https://github.com/IntelRealSense/realsense-ros.git -b ros2-development && \
      source /opt/ros/$ROS_DISTRO/setup.bash && \
      cd ~/ros2_ws && \
      colcon build --symlink-install

RUN cd ~/ros2_ws/src && \
      git clone https://github.com/pal-robotics/realsense_gazebo_plugin.git -b foxy-devel && \
      source /opt/ros/$ROS_DISTRO/setup.bash && \
      cd ~/ros2_ws && \
      colcon build --symlink-install

RUN cd ~/ros2_ws/src && \
      git clone https://github.com/koichirokato/gazebo_sensor_ros2 && \
      cd ~/ros2_ws && \
      source /opt/ros/$ROS_DISTRO/setup.bash && \
      colcon build --symlink-install && \
      source install/setup.bash

RUN export GAZEBO_MODEL_PATH=~/ros2_ws/install/realsense2_description/share/realsense2_description/meshes/:$GAZEBO_MODEL_PATH

RUN apt-get install -y ros-$ROS_DISTRO-xacro
RUN apt-get install terminator -y

RUN apt install ros-humble-rviz2 -y

RUN curl https://getmic.ro | bash;mv /micro /usr/local/bin/

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
      python3 get-pip.py && \
      rm get-pip.py

RUN apt install ros-humble-rqt -y
RUN apt install ros-humble-rqt-graph -y
RUN apt install ros-humble-rqt-tf-tree -y

# ここから参考書籍向けセットアップ
RUN pip3 install transforms3d
RUN apt install ros-humble-tf-transformations -y

RUN mkdir -p ~/airobot_ws/src && \
      cd ~/airobot_ws/src && \
      git clone https://github.com/AI-Robot-Book/appendixE && \
      cd ~/airobot_ws/ && \
      source /opt/ros/$ROS_DISTRO/setup.bash && \
      colcon build --symlink-install

RUN mkdir -p ~/airobot_ws/src && \
      cd ~/airobot_ws/src && \
      git clone https://github.com/AI-Robot-Book/chapter6.git && \
      cd ~/airobot_ws/ && \
      source /opt/ros/$ROS_DISTRO/setup.bash && \
      colcon build --symlink-install

RUN apt install ros-humble-joint-state-publisher-gui -y

RUN apt install  ros-humble-turtlebot3-gazebo -y

RUN mkdir -p ~/ros2_ws/src && \
      cd ~/ros2_ws/src && \
      git clone https://bitbucket.org/DataspeedInc/velodyne_simulator.git -b foxy-devel && \
      cd ~/ros2_ws && \
      source /opt/ros/$ROS_DISTRO/setup.bash && \
      colcon build --symlink-install

RUN cd ~/ros2_ws/src && \
      git clone https://github.com/ros-perception/pointcloud_to_laserscan -b humble && \
      cd ~/ros2_ws/ && \
      source /opt/ros/$ROS_DISTRO/setup.bash && \
      colcon build  --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Debug --packages-select pointcloud_to_laserscan

RUN cd ~/ros2_ws/src && \
      git clone https://github.com/ros-perception/depthimage_to_laserscan.git -b foxy-devel && \
      cd ~/ros2_ws/ && \
      source /opt/ros/$ROS_DISTRO/setup.bash  && \
      colcon build  --symlink-install  --packages-select depthimage_to_laserscan

RUN echo source ~/ros2_ws/install/setup.bash >> ~/.bashrc
RUN echo source /opt/ros/$ROS_DISTRO/setup.bash >> ~/.bashrc
RUN echo source /usr/share/gazebo/setup.bash >> ~/.bashrc
RUN echo alias python="python3" >> ~/.bashrc

RUN echo source ~/airobot_ws/install/setup.bash >> ~/.bashrc
# RUN echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc

RUN mkdir -p /etc/xdg/terminator
RUN touch /etc/xdg/terminator/config
