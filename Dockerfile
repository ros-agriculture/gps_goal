FROM osrf/ros:kinetic-desktop

ENV CATKIN_WS=/root/gps_goal_server_ws
RUN mkdir -p $CATKIN_WS/src

# update apt-get because osrf image clears this cache and download deps
RUN apt-get -qq update && \
    apt-get -qq install -y \
	apt-utils \
	libeigen3-dev \
        python-catkin-tools  \
        less \
        ssh \
	vim \
	terminator \
        git-core \
        bash-completion \
        wget

# HACK, replacing shell with bash for later docker build commands
RUN mv /bin/sh /bin/sh-old && \
    ln -s /bin/bash /bin/sh
COPY . .
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN echo "source $CATKIN_WS/devel/setup.bash" >> ~/.bashrc

# Build Repo
WORKDIR $CATKIN_WS
ENV TERM xterm
ENV PYTHONIOENCODING UTF-8

RUN apt-get -qq update && rosdep update && \
    rosdep install -y --from-paths . --ignore-src --as-root=apt:false && \
    rm -rf /var/lib/apt/lists/*

RUN source /ros_entrypoint.sh && \
    catkin build --no-status
