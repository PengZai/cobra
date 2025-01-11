#!/bin/bash



IMAGE_NAME="cobra_x86:ros_noetic-py3-torch-cuda"
DATA_PATH="/media/zhipeng/Extreme SSD/datasets"
# Pick up config image key if specified
if [[ ! -z "${CONFIG_DATA_PATH}" ]]; then
    DATA_PATH=$CONFIG_DATA_PATH
fi

cd $HOME/vscode_projects/cobra/catkin_ws
wstool init src
cd src
wstool merge cobra/cobra_https.rosinstall
wstoll update 
cd cobra



docker build -t $IMAGE_NAME -f "docker/Dockerfile_x86" .

xhost +local:docker

docker run --rm  \
  -e "DISPLAY=$DISPLAY"  \
  -e "QT_X11_NO_MITSHM=1" \
  -e "XAUTHORITY=$XAUTH"  \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw"  \
  -v "$DATA_PATH:/root/datasets" \
  -v "$HOME/vscode_projects/cobra/catkin_ws:/root/catkin_ws" \
  --ipc=host  --network host  \
  --runtime=nvidia --gpus=all  \
  --privileged  \
  --name cobra_x86 \
  -it $IMAGE_NAME

xhost -local:docker