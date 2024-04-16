terminator -e "ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py" &
cp map* $HOME
terminator -e "ros2 launch nav2_bringup bringup_launch.py use_sim_time:=True map:=$HOME/map.yaml" & # default_bt_xml_filename:=$HOME/btdata/sample.xml" &
terminator -e "ros2 run rviz2 rviz2 -d $(ros2 pkg prefix nav2_bringup)/share/nav2_bringup/rviz/nav2_default_view.rviz" &
terminator -e "python controller.py" &
