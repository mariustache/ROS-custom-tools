# ROS-custom-tools
Repository contains some tools for configuring/installing ROS.

**Install ROS version**

To install ROS version, run *install_ROS.sh* script:

` ./install_ROS.sh ROS_version`

Argument *ROS_version* can be: *kinetic*, *melodic*. The script checks if the ROS version is compatible with the Ubuntu distribution version. Also, the script checks
for other ROS versions sourced in *~/.bashrc* and replaces it with the current one
(there can only be one ROS version sourced in the environment).

**Create ROS workspace**

Run *create_ws_ROS.sh* script:

`./create_ws_ROS.sh workspace_name`

If no argument is passed, the default workspace name will be used.
