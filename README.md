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
