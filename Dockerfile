FROM osrf/ros:melodic-desktop-full

RUN mkdir -p /catkin_ws/src

RUN cd /catkin_ws/src \
 && git clone https://github.com/ICAR-2021/HIL_airmanip.git \
 && git clone https://github.com/ethz-asl/rotors_simulator.git --single-branch 

RUN cd /catkin_ws \
 && /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && apt-get update && rosdep install --as-root apt:false --from-paths src --ignore-src -r -y" \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN cd /catkin_ws \
 && source /opt/ros/${ROS_DISTRO}/setup.bash \
 && catkin_make
