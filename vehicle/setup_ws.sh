#!/bin/bash

# 引数の取得
WORKSPACE_NAME=$1
PACKAGE_NAME=$2

# 引数のチェック
if [ -z "$WORKSPACE_NAME" ]; then
  echo "ワークスペースディレクトリ名を指定してください。"
  exit 1
fi

if [ -z "$PACKAGE_NAME" ]; then
  echo "パッケージ名を指定してください。"
  exit 1
fi

if [ -d "$WORKSPACE_NAME" ]; then
  echo $WORKSPACE_NAME "が既に存在しています。"
  exit 1
fi


# ワークスペースディレクトリの作成
mkdir -p $WORKSPACE_NAME/src

# ワークスペースディレクトリへの移動
cd $WORKSPACE_NAME

# パッケージの作成
ros2 pkg create --build-type ament_python $PACKAGE_NAME --dependencies rclpy

# launch ディレクトリの作成
mkdir -p src/$PACKAGE_NAME/launch

# サンプル launch.py ファイルの作成
cat << EOF > src/$PACKAGE_NAME/launch/sample_launch.py
from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import ExecuteProcess

def generate_launch_description():
    return LaunchDescription([
        ExecuteProcess(
            cmd=['gazebo', '--verbose', 'my_custom_world.world'],
            output='screen'
        ),
    ])
EOF

# ビルド
colcon build

# インストール
source install/local_setup.bash

# launchファイルのコピー
cp src/$PACKAGE_NAME/launch/sample_launch.py install/my_robot/share/my_robot

echo "ワークスペース '$WORKSPACE_NAME'、パッケージ '$PACKAGE_NAME' の作成、ビルド、インストールが完了しました。"
