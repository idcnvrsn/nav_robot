#!/bin/bash
export ROS_DISTRO=humble

echo source /opt/ros/$ROS_DISTRO/setup.bash >> ~/.bashrc
echo "source /usr/share/gazebo/setup.sh" >> ~/.bashrc
echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc
echo source /opt/ros2_ws/install/setup.bash >> ~/.bashrc
echo 'export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/turtlebot3_ws/src/turtlebot3/turtlebot3_simulations/turtlebot3_gazebo/models' >> ~/.bashrc

exec "$@"
