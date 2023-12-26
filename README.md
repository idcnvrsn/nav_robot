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
