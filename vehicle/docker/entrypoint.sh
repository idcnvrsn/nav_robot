#!/bin/bash
echo source /opt/ros/humble/setup.bash >> ~/.bashrc

exec "$@"
