ARG ROS_DISTRO="ROS_DISTRO"
FROM osrf/ros:${ROS_DISTRO}-desktop-full

SHELL ["/bin/bash", "-c"]

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN apt update
# RUN apt install ros-${ROS_DISTRO}-desktop-full -y
RUN apt install terminator -y

RUN apt install ros-${ROS_DISTRO}-gazebo-* -y
RUN apt install ros-${ROS_DISTRO}-navigation2 -y
RUN apt install ros-${ROS_DISTRO}-nav2-bringup -y

RUN apt install gazebo -y

RUN apt install ros-${ROS_DISTRO}-dynamixel-sdk \
                ros-${ROS_DISTRO}-turtlebot3-msgs \
                ros-${ROS_DISTRO}-turtlebot3 -y

RUN apt install ros-$ROS_DISTRO-turtlebot3-gazebo -y

RUN apt install nano -y

RUN apt-get install ros-humble-urdf-tutorial ros-humble-urdf-launch -y

RUN apt install ros-humble-rqt-tf-tree -y

RUN apt-get install ros-$ROS_DISTRO-realsense2-camera -y

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
RUN apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev -y

RUN mkdir -p /opt/ros2_ws/src
RUN cd /opt/ros2_ws/src && \
    git clone https://github.com/IntelRealSense/realsense-ros.git && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    cd /opt/ros2_ws && \
    colcon build --symlink-install

RUN cd /opt/ros2_ws/src && \
    git clone https://github.com/pal-robotics/realsense_gazebo_plugin.git -b foxy-devel && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    cd /opt/ros2_ws && \
    colcon build --symlink-install

RUN cd /opt/ros2_ws/src && \
    git clone https://github.com/koichirokato/gazebo_sensor_ros2 && \
    cd /opt/ros2_ws && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    colcon build --symlink-install

RUN cd /opt/ros2_ws/src && \
    git clone https://github.com/yadunund/view_sdf_rviz && \
    cd /opt/ros2_ws && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y && \
    colcon build --symlink-install

RUN mkdir -p /etc/xdg/terminator && touch /etc/xdg/terminator/config
RUN apt-get update -y && apt-get install -y x11-apps

# Rust と cargo のインストール先を変更するための環境変数を設定
# CARGO_HOME と RUSTUP_HOME を変更
ENV CARGO_HOME=/opt/rust/cargo
ENV RUSTUP_HOME=/opt/rust/rustup

# rustup をインストールして rust と cargo をセットアップ
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="${CARGO_HOME}/bin:${PATH}"

RUN cargo install urdf-viz

RUN apt install ros-humble-slam-toolbox -y

RUN apt install ros-humble-turtlebot3-teleop -y

# entrypoint.shスクリプトをコンテナに追加
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh", "/bin/bash"]

ARG USERNAME=develop
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME

