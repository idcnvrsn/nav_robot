#!/bin/bash
export ROS_DISTRO=humble

echo source /opt/ros/$ROS_DISTRO/setup.bash >> ~/.bashrc
echo "source /usr/share/gazebo/setup.sh" >> ~/.bashrc
echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc
echo source /opt/ros2_ws/install/setup.bash >> ~/.bashrc

exec "$@"
