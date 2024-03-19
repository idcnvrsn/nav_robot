#!/bin/bash

# Run build, and get parameters
. ./build.sh >& /dev/null

docker run \
--env http_proxy=${HTTP_PROXY} \
--env https_proxy=${HTTPS_PROXY} \
--env NO_PROXY=$NO_PROXY \
--hostname $HOSTNAME \
--net=host \
-e DISPLAY=$DISPLAY \
--env MPLCONFIGDIR=${MPLCONFIGDIR} \
-it \
--rm \
-v /etc/localtime:/etc/localtime:ro \
-v ${HOME}/.bash_history:${HOME}/.bash_history \
-v ${HOME}/seaborn-data:${HOME}/seaborn-data \
-v ${PWD}/../..:/work/shared \
-v /mnt/mlflow:/mnt/mlflow \
-v ${HOME}/.keras:${HOME}/.keras \
-v ${HOME}/data:${HOME}/data \
-v ${HOME}/.cache:${HOME}/.cache \
-v ${HOME}/.config:${HOME}/.config \
-v ${HOME}/.torch/iopath_cache:${HOME}/.torch/iopath_cache \
-w /work/shared/${BASENAME} \
--shm-size=10240m \
--privileged \
${BASENAME}

# -u "$(id -u $(whoami)):$(id -g $(whoami))" \
# -v /etc/passwd:/etc/passwd:ro \
# -v /etc/group:/etc/group:ro \

#--gpus '"device=0"' \
