#!/bin/bash
ROS_DISTRO=humble
BASENAME=realsense
DOCKERFILE=${1:-Dockerfile}

docker buildx build \
  --build-arg ROS_DISTRO=${ROS_DISTRO} \
  --build-arg NGC_TAG=${NGC_TAG} \
  --build-arg http_proxy=${http_proxy} \
  --build-arg https_proxy=${https_proxy} \
  --build-arg no_proxy=${no_proxy} \
  --build-arg HTTP_PROXY=${HTTP_PROXY} \
  --build-arg HTTPS_PROXY=${HTTPS_PROXY} \
  --build-arg NO_PROXY=${NO_PROXY} \
  --progress plain \
  -t ${BASENAME} \
  .
