FROM osrf/ros:melodic-desktop-full

RUN mkdir -p /catkin_ws/src

RUN cd /catkin_ws/src \
 && git clone https://github.com/ICAR-2021/HIL_airmanip.git \
 && git clone https://github.com/ethz-asl/rotors_simulator.git --single-branch 

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 4B63CF8FDE49746E98FA01DDAD19BAB3CBF125EA

RUN cd /catkin_ws \
 && apt-get update \
 && rosdep install --from-paths src --ignore-src -r -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN cd /catkin_ws \
 && source /opt/ros/${ROS_DISTRO}/setup.bash \
 && catkin_make

