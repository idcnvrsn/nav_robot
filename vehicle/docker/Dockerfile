FROM ros:humble-perception

ENV ROS_DISTRO=humble

SHELL ["/bin/bash", "-c"]

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN apt update
RUN apt install ros-${ROS_DISTRO}-desktop-full -y
RUN apt install terminator -y

RUN apt install ros-${ROS_DISTRO}-gazebo-* -y
RUN apt install ros-${ROS_DISTRO}-navigation2 -y
RUN apt install ros-${ROS_DISTRO}-nav2-bringup -y

RUN apt install gazebo ros-${ROS_DISTRO}-gazebo-ros-pkgs -y

RUN source ~/.bashrc && \
  apt install ros-${ROS_DISTRO}-dynamixel-sdk -y && \
  apt install ros-${ROS_DISTRO}-turtlebot3-msgs -y && \
  apt install ros-${ROS_DISTRO}-turtlebot3 -y

RUN mkdir -p ~/turtlebot3_ws/src && cd ~/turtlebot3_ws/src && \
  git clone -b humble-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git && \
  cd ~/turtlebot3_ws && \
  source /opt/ros/$ROS_DISTRO/setup.bash && \
  colcon build --symlink-install

RUN apt install nano -y

RUN cd ~ && git clone https://github.com/dheera/rospy2.git && cd ~/rospy2 && \
  python3 setup.py install

RUN apt-get install ros-humble-urdf-tutorial ros-humble-urdf-launch -y

RUN apt-get install liburdfdom-tools -y

RUN apt install ros-humble-rqt-tf-tree -y

RUN echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:~/turtlebot3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc
RUN echo source /opt/ros/$ROS_DISTRO/setup.bash >> ~/.bashrc
RUN echo "source ~/turtlebot3_ws/install/setup.bash" >> ~/.bashrc
RUN echo "source /usr/share/gazebo/setup.sh" >> ~/.bashrc

RUN echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc

RUN mkdir -p /etc/xdg/terminator && touch /etc/xdg/terminator/config

RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
RUN echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc
