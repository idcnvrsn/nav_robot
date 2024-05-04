ARG ROS_DISTRO
FROM osrf/ros:${ROS_DISTRO}-desktop-full

SHELL ["/bin/bash", "-c"]

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN apt update
# RUN apt install ros-${ROS_DISTRO}-desktop-full -y
RUN apt install terminator -y

RUN apt install ros-${ROS_DISTRO}-gazebo-* -y
RUN apt install ros-${ROS_DISTRO}-navigation2 -y
RUN apt install ros-${ROS_DISTRO}-nav2-bringup -y

RUN apt install gazebo -y

RUN apt install ros-${ROS_DISTRO}-dynamixel-sdk \
                ros-${ROS_DISTRO}-turtlebot3-msgs \
                ros-${ROS_DISTRO}-turtlebot3 -y

RUN apt install ros-$ROS_DISTRO-turtlebot3-gazebo -y

RUN apt install nano -y

RUN apt-get install ros-humble-urdf-tutorial ros-humble-urdf-launch -y

RUN apt install ros-humble-rqt-tf-tree -y

RUN apt-get install ros-$ROS_DISTRO-realsense2-camera -y

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
    colcon build --symlink-install

RUN export GAZEBO_MODEL_PATH=~/ros2_ws/install/realsense2_description/share/realsense2_description/meshes/:$GAZEBO_MODEL_PATH

RUN echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/turtlebot3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc
RUN echo source ~/ros2_ws/install/setup.bash >> ~/.bashrc
RUN echo source /opt/ros/$ROS_DISTRO/setup.bash >> ~/.bashrc
RUN echo "source /usr/share/gazebo/setup.sh" >> ~/.bashrc

RUN echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc

RUN mkdir -p /etc/xdg/terminator && touch /etc/xdg/terminator/config

RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
RUN echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc
