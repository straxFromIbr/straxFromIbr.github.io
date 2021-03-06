---
title: "SysV initで起動するDockerでプロキシを適用する"
date: 2021-10-06T12:58:40+09:00
categories:
- プログラミング
- Docker
tags:
- プログラミング
- Docker
- WSL
- Windows

keywords:
- プログラミング
- Docker
- WSL
- Windows
- tech
#thumbnailImage: /images/systemv-docker-proxy/
#thumbnailImage: //example.com/image.jpg
summary: "Dockerに限らずSysV initで起動するデーモンの環境変数などの設定"

---

# 問題点
プロキシ環境下で次のチュートリアル、
[CUDA on WSL User Guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)
に従いWSLにDockerをインストールしたところ、`docker pull`時にタイムアウトが発生した。

恥ずかしながらあまり使ったことがなかった`service`で起動しており、解決に少し時間がかかったのでメモ。

# 解決策

`/etc/default/docker`に以下を追記:
URLは適宜変更。
```bash
export http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
export https_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
```
`$http_proxy`に限らず、起動時に指定したい環境変数などを複数記述できる。

これは次の操作で実現される環境と多分同等。
```bash
export http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
export https_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
sudo -E dockerd
```
