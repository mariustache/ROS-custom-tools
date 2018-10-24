#!/usr/bin/env bash

# check if an argument has been passed
if [ ! $# -gt 0 ]; then
	echo "No arguments passed.
Please provide ROS version. (e.g.: kinetic)"
	exit 1
fi

# setup computer to accept software from packages.ros.org
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# set up keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# update Debian package index
sudo apt-get update

# check linux version:
# --kinetic - 15.10, 16.04 LTS
# --melodic - 17.10, 18.04 LTS
LINUX_VRS=$(cat /etc/*release | grep DISTRIB_RELEASE | awk -F "=" '{print $2}')
declare -A KINETIC_ARR=(["15.10"]=1 ["16.04"]=1)
declare -A MELODIC_ARR=(["17.10"]=1 ["18.04"]=1)

if [ "$1" = "kinetic" ] && [ "${KINETIC_ARR[$LINUX_VRS]}" ]; then
	echo "Installing ROS $1. Linux Ubuntu version $LINUX_VRS."
	sudo apt-get install ros-kinetic-desktop-full
elif [ "$1" = "melodic" ] && [ "${MELODIC_ARR[$LINUX_VRS]}" ]; then
	echo "Installing ROS $1. Linux Ubuntu version $LINUX_VRS."
	sudo apt-get install ros-melodic-desktop-full
else
	echo "ROS $1 is not compatible with Ubuntu $LINUX_VRS."
	exit 1
fi

# init rosdep (for system dependencies required for compile/run)
sudo rosdep init
rosdep update

# make sure no other ROS version is sourced;
# if there's another version, overwrite it
sed -i "s/source \/opt\/ros\/.*/source \/opt\/ros\/$1\/setup.bash/" ~/.bashrc
# environment setup
source ~/.bashrc

# install dependencies for building packages
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential
