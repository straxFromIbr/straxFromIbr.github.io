---
title: "PostgreSQLをSQLAlchemyで使用する"
date: 2021-08-22T11:44:02+09:00
categories:
- プログラミング
- Python
tags:
- プログラミング
- Python
- データベース
- SQL
- PostgreSQL
- M1Mac
#thumbnailImage: /images/postgresql-sqlalchemy/
#thumbnailImage: //example.com/image.jpg

#{{< image classes="fancybox clear fig-100 center" src="/images/postgresql-sqlalchemy/" title="">}}

summary: PostgreSQLをSQLAlchemyから操作する。

---

PostgreSQLをSQLAlchemyから操作する。

<!--toc-->
# 環境
- ハードウェア : M1 Mac
- OS : macOS 12.0 Monterey Beta
- Python 3.8.2 
- postgres (PostgreSQL) 13.4
- SQLAlchemy : 1.4.23

# 使用ライブラリのインストール
```
brew install postgresql
python3 -m pip install sqlalchemy psycopg2
```

# PostgreSQLの起動とデータベースの作成
```
brew services start postgresql
createdb $DATABASE_NAME
```
`psql -l`コマンドでデータベースの一覧を確認できる。


# SQLAlchemyで接続
```python
from sqlalchemy import create_engine

username = "$USERNAME"
password = "$PASSWORD"
host = "localhost"
port = 5432
dbname = "mydb"

engine = create_engine(f"postgresql://{username}:{password}@{host}:{port}/{dbname}")
engine.execute("create table testtbl (id integer, body text);")
engine.execute("insert into testtbl values (0, 'hello world');")
r = engine.execute("select * from testtbl;")
print(list(r))
```
`[(0, 'hello world')]`のような出力が得られる。

