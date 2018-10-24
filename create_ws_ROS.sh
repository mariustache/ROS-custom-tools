#!/usr/bin/env bash

HOME_PATH=$(echo ~)

# set workspace name
if [ $# -gt 0 ]; then
	WS_NAME=$1
else
	WS_NAME="default_ws"
fi

echo "
Creating workspace tree:

-$HOME_PATH/$WS_NAME:
  |-src
"

mkdir -p ~/$WS_NAME/src
cd ~/$WS_NAME

catkin_make

# source workspace setup.bash
if grep "source ~/$WS_NAME/devel/setup.bash" ~/.bashrc; then
	:
else
	echo "source ~/$WS_NAME/devel/setup.bash" >> ~/.bashrc
fi

echo $ROS_PACKAGE_PATH
