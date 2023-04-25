# 概要
トリッキーな使い方を忘れてしまうのでもういちど書いて覚えるリポジトリ。

# 使い方
docker compozeでpostgreSQLを起動して、SQLで遊ぶ。

script/02_create_table.sql をパクってテーブルを作ればとりあえず動かせる。script配下は起動時に実行されるようになってる。

## ファイルを増やしたら
以下でPostgreSQLのデータを保存しているボリュームを削除する。
```shell
docker compose ps
docker compose stop
docker compose ps

docker ps -a
docker rm sql_puzzle_postgresql
docker ps -a

docker volume ls
docker volume rm sql_puzzle_db-store
docker volume ls

docker compose up -d
docker compose ps
```
ボリューム名は変わるかも




