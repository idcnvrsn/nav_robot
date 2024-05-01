source second_ros2_ws/install/setup.bash
terminator -e "ros2 launch urdf_tutorial_r2d2 demo.launch.py" &
terminator -e "rviz2 -d second_ros2_ws/src/urdf_tutorial_r2d2/urdf/r2d2.rviz" &
