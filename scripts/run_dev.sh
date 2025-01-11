#!/bin/bash



IMAGE_NAME="cobra_x86:ros_noetic-py3-torch-cuda"
DATA_PATH="/home/zhipeng/datasets"
# Pick up config image key if specified
if [[ ! -z "${CONFIG_DATA_PATH}" ]]; then
    DATA_PATH=$CONFIG_DATA_PATH
fi


PROJECT_DIR=$(pwd)
PROJECT_NAME=$(basename "$PWD")


docker build -t $IMAGE_NAME -f "$PROJECT_DIR/catkin_ws/src/$PROJECT_NAME/docker/Dockerfile_x86" .

xhost +local:docker

docker run --rm  \
  -e "DISPLAY=$DISPLAY"  \
  -e "QT_X11_NO_MITSHM=1" \
  -e "XAUTHORITY=$XAUTH"  \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"  \
  -v "$DATA_PATH:/root/datasets" \
  -v $PROJECT_DIR/catkin_ws:/root/catkin_ws \
  --ipc=host  --network host  \
  --runtime=nvidia --gpus=all  \
  --privileged  \
  --name kimera-vio-noetic-container \
  -it kimera-vio:noetic-ros

xhost -local:docker