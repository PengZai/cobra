

xhost +local:docker

docker run --rm \
    -e DISPLAY \
    -v ~/.Xauthority:/root/.Xauthority:rw \
    --network host \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /home/zhongzhipeng/vscode_projects/cobra/catkin_ws:/root/catkin_ws \
    -v /mnt/usb/datasets:/root/datasets \
    --privileged \
    --cap-add sys_ptrace \
    --runtime=nvidia \
    --gpus all \
    -it --name cobra cobra_x86:ros_noetic-py3-torch-cuda /bin/bash

xhost -local:docker