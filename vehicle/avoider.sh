terminator -e "roslaunch turtlebot3_gazebo turtlebot3_world.launch" &
sleep 5
cp map* $HOME
terminator -e "roslaunch turtlebot3_navigation turtlebot3_navigation.launch map_file:=$HOME/map.yaml" &
sleep 5
terminator -e "python controller.py" &
