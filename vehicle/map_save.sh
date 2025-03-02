sudo cp my_room.launch.py /opt/ros/humble/share/turtlebot3_gazebo/launch/
sudo cp worlds/my_room.world /opt/ros/humble/share/turtlebot3_gazebo/worlds
terminator -e "ros2 launch turtlebot3_gazebo my_room.launch.py" &

terminator -e "ros2 launch slam_toolbox online_async_launch.py params_file:=slam_toolbox_params.yaml" &
terminator -e "ros2 run rviz2 rviz2 -d $(ros2 pkg prefix nav2_bringup)/share/nav2_bringup/rviz/nav2_default_view.rviz" &
terminator -e "ros2 run turtlebot3_teleop teleop_keyboard" &

# teleopでworld内を動き回って、マップを作る。

# 以下を実施してmap保存する。 既存ファイルの上書き保存はできない模様
# ros2 run nav2_map_server map_saver_cli -f my_map

