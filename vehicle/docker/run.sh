#!/bin/bash
# Run build, and get parameters
. ./build.sh >& /dev/null

if [ ! -e $HOME/.gazebo ]; then
  echo "mkdir" $HOME/.gazebo
  mkdir $HOME/.gazebo
fi

docker run \
-it \
--rm \
 -v /tmp/.X11-unix/:/tmp/.X11-unix \
 -v $HOME/.Xauthority:/root/.Xauthority:rw \
 -v $PWD/../..:/work/share \
 -v $HOME/.gazebo:$HOME/.gazebo \
 -v $HOME/.bash_history:/root/.bash_history \
 -w /work/share/vehicle \
  -v /etc/localtime:/etc/localtime:ro \
  --env NVIDIA_DRIVER_CAPABILITIES=video,compute,utility \
  --env NVIDIA_VISIBLE_DEVICES=$GPU \
  --env KERAS_BACKEND=tensorflow \
  --env HTTP_PROXY=$HTTP_PROXY \
  --env HTTPS_PROXY=$HTTPS_PROXY \
  --env NO_PROXY=$NO_PROXY \
  --env http_proxy=$http_proxy \
  --env https_proxy=$https_proxy \
  --env no_proxy=$no_proxy \
  --env RUN_USER=$RUN_USER \
  --env RUN_UID=$RUN_UID \
  --env RUN_GROUP=$RUN_GROUP \
  --env RUN_GID=$RUN_GID \
--privileged \
  --env DISPLAY=$DISPLAY \
  --net host \
  --shm-size=1g \
${BASENAME}


# -u "$(id -u $(whoami)):$(id -g $(whoami))" \
# -v /etc/passwd:/etc/passwd:ro \
# -v /etc/group:/etc/group:ro \
