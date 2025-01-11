cd /root/catkin_ws/src/glimpse_nvblox_ros1/nvblox/nvblox
mkdir build && cd build && cmake .. && make -j3


cd /root/catkin_ws
catkin build pointcloud_image_converter nvblox_ros nvblox_rviz_plugin -DCMAKE_BUILD_TYPE=Release