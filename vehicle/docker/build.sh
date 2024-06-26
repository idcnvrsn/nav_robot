BASENAME=vehicle_ros2
ROS_DISTRO=humble

docker buildx build \
  --build-arg ROS_DISTRO=${ROS_DISTRO} \
  --build-arg HTTP_PROXY=${HTTP_PROXY} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY} \
  --build-arg NO_PROXY=${NO_PROXY} \
  --build-arg http_proxy=${http_proxy} \
  --build-arg https_proxy=${https_proxy} \
  --build-arg no_proxy=${no_proxy} \
. -t ${BASENAME}
