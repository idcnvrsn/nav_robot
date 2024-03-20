terminator -e "ros2 launch gazebo_sensor_ros2 realsense_gazebo.launch.py" &
sleep 3
terminator -e "rviz2 -d ~/ros2_ws/src/gazebo_sensor_ros2/rviz/config.rviz" &
cp depthimage_to_laserscan-launch.py /root/ros2_ws/install/depthimage_to_laserscan/share/depthimage_to_laserscan/launch/
cp param.yaml /root/ros2_ws/install/depthimage_to_laserscan/share/depthimage_to_laserscan/cfg/param.yaml
terminator -e "ros2 launch depthimage_to_laserscan depthimage_to_laserscan-launch.py" &
