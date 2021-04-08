#!/bin/bash

# to home dir
cd;

# standard stuff
sudo apt update && sudo apt upgrade;
sudo apt install -y git lsub;

# git 
git clone https://github.com/ctm6100/vesc.git

# move the file
mv ./vesc/vesc ~/catkin_ws/src
mv ./vesc/vesc_driver ~/catkin_ws/src
mv ./vesc/vesc_hw_interface ~/catkin_ws/src
mv ./vesc/vesc_msgs ~/catkin_ws/src

# instal ros serial(For ROS noetic)
test=$(lsb_release -sc)
echo "${test}"
if [ "${test}" == "focal" ]; then
        echo "Ubuntu verison Check...."
        lsb_release -a
        echo "For ROS noetic, ROS Packet: Serial need to manually install" ${test} 
        read -p "Do you want auto install Serial for you(Y/n)" yn
        if [ "${yn}" != "Y" ]; then
                cd ~/catkin_ws/src;
                git clone https://github.com/wjwwood/serial.git;
                cd serial;
                make
                make install
        fi
else
  sudo apt-get install -y ros-$ROS_DISTRO-serial;
fi

# intall other dependent
sudo apt-get install -y ros-$ROS_DISTRO-ros-control ros-$ROS_DISTRO-hardware-interface ros-$ROS_DISTRO-controller-manager;

#complie the package
source ~/catkin_ws/devel/setup.bash;
cd ~/catkin_ws;
catkin_make vesc_msgs;
catkin_make;

#USB permission stuff
sudo usermod -a -G dialout $USER;
echo "cuurent user is add to the dialout group, re-login to apply the change."
echo "Or you can use sudo chmod 666 /dev/theUSBPortName everytime"
echo "roslaunch vesc_driver <your launch file>"
