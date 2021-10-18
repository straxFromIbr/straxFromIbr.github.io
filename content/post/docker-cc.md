---
title: "[Docker/M1] Dockerコンテナ上にCコンパイラが動く環境をつくる"
date: 2021-10-18T21:41:59+09:00
categories:
- プログラミング
- Docker
tags:
- プログラミング
- Docker
- C
- M1Mac
- AppleSilicon
- Linux
keywords:
- プログラミング
- Docker
- C
- Linux
- M1Mac
- AppleSilicon
#thumbnailImage: /images/docker-cc/
#thumbnailImage: //example.com/image.jpg
summary: "M1MacでDockerコンテナ上にx86アーキテクチャのCコンパイラが動く環境をつくる"

---
学生実験で、Linux向けにコンパイルされたオブジェクトファイルが配布されたのでDockerを使用して環境を作った。

# Docker用のファイル
最新のUbuntuをベースイメージとし、gccとmakeをインストールする。またワーキングディレクトリを`/home`とする。

- `Dockerfile`
```Docker
FROM ubuntu:latest

WORKDIR /home

RUN apt update && \
    apt upgrade -y && \
    apt install gcc make -y

CMD ["/usr/bin/bash","-l"]
```

カレントディレクトリの`working`をコンテナの`/home`にマウントする。
またビルド時の引数で明示的にx86アーキテクチャを指定している。
-  `docker-compose.yml`
```yaml
version: '3.3'
services:
    aesdev:
        image: exp6_aes
        build:
          context: .
          dockerfile: ./Dockerfile
          args:
            - platform='linux/amd64'
            - tag='exp6_aes'
        command: /bin/bash
        volumes:
            - './working:/home'
```

# イメージのビルドとコンテナの起動
```
docker-compose build
docker-compose run aesdev
```



            


