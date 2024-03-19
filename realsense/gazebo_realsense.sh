terminator -e "ros2 launch gazebo_sensor_ros2 realsense_gazebo.launch.py" &
# terminator -e "ros2 launch turtlebot3_gazebo turtlebot3_world_no_robot.launch.py" &
sleep 3
terminator -e "rviz2 -d ~/ros2_ws/src/gazebo_sensor_ros2/rviz/config.rviz" &
cp pointcloud_to_laserscan.launch.py ~/ros2_ws/install/pointcloud_to_laserscan/share/pointcloud_to_laserscan/launch
terminator -e "ros2 launch pointcloud_to_laserscan pointcloud_to_laserscan.launch.py" &
