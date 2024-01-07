# nav_robot

docker-ceのインストール

```
curl -fsSL get.docker.com -o get-docker.sh && \ # ダウンロード
  sh get-docker.sh && \                         # 実行
  sudo gpasswd -a $USER docker && \             # カレントユーザーを docker グループに追加（注１）
  sudo docker run hello-world && \              # Docker のテスト実行
  rm -f get-docker.sh                           # インストーラーの削除
```
参考：
https://qiita.com/KEINOS/items/bdc9450c1a88c210aa88

dockerイメージのビルド  
cd nav_robot/vehicle/docker  
./build.sh  

dockerイメージの起動  
./run.sh

urdfのテスト参考：  
https://qiita.com/Ninagawa123/items/411746933d221cb43e9d

urdfファイルのチェックにはcheck_urdfというツールが使える：  
https://qiita.com/srs/items/35bbaadd6c4be1e39bb9#urdf%E3%81%AE%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF

ros2向けurdf_tutorial:  
https://github.com/ros/urdf_tutorial/tree/ros2?tab=readme-ov-file

pythonのみを使うパッケージ(ビルドツールにament_pythonをしたしたとき)におけるros2 launchファイル実行例：

```
mkdir -p ~/happy_ws/src/chapter2
cd ~/happy_ws/src/chapter2
ros2 pkg create --build-type ament_python --node-name hello_node hello
cd ~/happy_ws
colcon build
source install/setup.bash

ros2 run hello hello_node

mkdir -p ~/happy_ws/src/chapter2/hello/launch
cd ~/happy_ws/src/chapter2/hello/launch

echo -e "\
from launch import LaunchDescription\n\
from launch_ros.actions import Node\n\

def generate_launch_description():\n\
    return LaunchDescription([\n\
        Node(\n\
            package='hello',\n\
            namespace='hello',\n\
            executable='hello_node',\n\
        ),\n\
    ])" \
> launch.py

sed -i "13i ('share/' + package_name, ['launch/launch.py'])," ~/happy_ws/src/chapter2/hello/setup.py

cd ~/happy_ws
colcon build
source install/setup.bash

ros2 launch hello launch.py
```
ros2におけるパッケージの開発のチュートリアル(C++,python)：  
https://docs.ros.org/en/foxy/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html

ros2におけるlaunchファイル作成のチュートリアル(C++,python)：  
https://docs.ros.org/en/foxy/Tutorials/Intermediate/Launch/Launch-system.html

rosパッケージの検索サイト:  
https://index.ros.org/

sdfファイルについて：  
sdfファイルフォーマットに関するまとまった資料が見当たらないようだが例えばgazebo tutrialなどに
gazeboチュートリアルブラウズページ
https://classic.gazebosim.org/tutorials/browse
sdf関係のチュートリアル例：
https://classic.gazebosim.org/tutorials?tut=build_model&cat=build_robot
https://classic.gazebosim.org/tutorials?tut=build_robot&cat=build_robot

gazebo world
gazeboによるチュートリアル：  
https://classic.gazebosim.org/tutorials?tut=build_world&cat=build_world
https://classic.gazebosim.org/tutorials?tut=modifying_world&cat=build_world

■RealSense関係
realsenseのROSパッケージ：  
https://github.com/IntelRealSense/realsense-ros

realsenseをgazeboでシミュレーションするROSパッケージ(intel製ではなくサードパーティらしい)：  
https://github.com/pal-robotics/realsense_gazebo_plugin/tree/foxy-devel?tab=readme-ov-file

intel製のrealsense gazeboプラグイン（現在メンテナンスされてないらしい）：   
https://github.com/intel/gazebo-realsense


