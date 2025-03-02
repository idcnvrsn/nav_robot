sudo cp my_room.launch.py /opt/ros/humble/share/turtlebot3_gazebo/launch/
sudo cp worlds/my_room.world /opt/ros/humble/share/turtlebot3_gazebo/worlds
terminator -e "ros2 launch turtlebot3_gazebo my_room.launch.py" &

cp my_room_map* $HOME
terminator -e "ros2 launch nav2_bringup bringup_launch.py use_sim_time:=True map:=$HOME/my_room_map.yaml" &
terminator -e "ros2 run rviz2 rviz2 -d $(ros2 pkg prefix nav2_bringup)/share/nav2_bringup/rviz/nav2_default_view.rviz" &
terminator -e "python controller.py" &
