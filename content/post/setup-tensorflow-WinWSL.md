---
title: "研究室のPCの環境構築メモ"
date: 2021-10-11T14:02:08+09:00
categories:
- 卒研
- 環境構築
tags:
- 卒研
- 環境構築
summary: "研究室のPCの環境構築メモ"
---
オリジナルのドキュメントは
共有フォルダ(`~/Desktop/RX3070`)においてある。


 - [Dockerのセットアップ](#dockerのセットアップ)
 - [OpenSSHの設定(Win11上)](#opensshの設定win11上)
 - [リモートのDockerのJupyterにローカルマシンから接続する](#リモートのdockerのjupyterにローカルマシンから接続する)

## Dockerのセットアップ
[CUDA on WSL User Guide](https://docs.nvidia.com/cuda/wsl-user-guide/index.html)に従いDockerのインストールまで行う。(主にWSL上の操作)
1. Windows 11にアップデート
2. WSL2(ubuntu)のインストール
3. プロキシの設定1  
WSL2上で次のようにファイルを編集
- `~/.wgetrc`

```
http_proxy=http://po.cc.ibaraki-ct.ac.jp:3128
https_proxy=http://po.cc.ibaraki-ct.ac.jp:3128
```
- `~/.curlrc`

```
proxy=po.cc.ibaraki-ct.ac.jp:3128
```

- `/etc/apt/aptconf`  

```
Acquire::http::Proxy "http://po.cc.ibaraki-ct.ac.jp:3128";
Acquire::https::Proxy "http://po.cc.ibaraki-ct.ac.jp:3128";
```

4. CUDAドライバーのインストール
5. WSLバックエンドのDockerのインストール
6. プロキシの設定2  
- WSL2でファイル`/etc/default/docker`に次を追記  

```
export  http_proxy="http://po.cc.ibaraki-ct.ac.jp:3128"
export https_proxy="http://po.cc.ibaraki-ct.ac.jp:3128"
```
7. GPUの確認
    - `docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark`をエラーなく実行できることを確認
8. TensorFlowとJupyter Notebookの確認
    - `docker run -it --gpus all -p 8888:8888 tensorflow/tensorflow:latest-gpu-py3-jupyter`を実行
    - ブラウザで[http://localhost:8888](http://localhost:8888)に接続し`import tensorflow`が実行できるか確認
    - 実行したら終了

 
## OpenSSHの設定(Win11上)
1. スタートメニューで`オプション`を開き、`OpenSSH Server`を有効にする。
2. `セキュリティが強化されたWindows Defender ファイアウォール`を開き設定
    1. `受信の規則/新しい規則`を開き、自分のPCのIPアドレスからのアクセスを許可
    2. 自分のPCからpingが到達することを確認
3. SSHが接続できるか確認

## リモートのDockerのJupyterにローカルマシンから接続する  
1. ローカル  
SSH接続をする。このときリモートの8888ポートをローカルの同番号にフォワードする。
```
ssh -L 8888:localhost:8888 r-kodama@172.16.161.107
```
2. リモート(WSL2)  
次ののようにしてJupyterのパスワードを設定。出力されるハッシュ値をメモ。
```
docker run --rm -it --gpus all -v /mnt/c/Users/r-kodama/Desktop/RX3070/haga_2021:/home -p 8888:8888 tensorflow/tensorflow:latest-gpu-py3-jupyter  python -c 'from notebook.auth import passwd;print(passwd())'
```

3. リモート(WSL2)  
前手順で取得したハッシュを指定しJupyterを起動
```
docker run -it --gpus all -p 8888:8888 tensorflow/tensorflow:latest-gpu-py3-jupyter jupyter notebook --allow-root --ip=0.0.0.0 --NotebookApp.password=${ハッシュ}
```
パスワードをすでに決めた場合は次のようにPowerShellまたはCMDから直接実行できる
```
wsl HTTP_PROXY='http://po.cc.ibaraki-ct.ac.jp:3128' docker run --rm -it --gpus all --env HTTP_PROXY='po.cc.ibaraki-ct.ac.jp:3128' --env HTTPS_PROXY='po.cc.ibaraki-ct.ac.jp:3128' -v /mnt/c/Users/r-kodama/Desktop/RX3070/haga_2021:/home -p 8888:8888 tensorflow/tensorflow:latest-gpu-py3-jupyter  jupyter notebook --allow-root --ip=0.0.0.0 --NotebookApp.password='sha1:96686e15b7d0:616a406a297c71a3f824aac48a9cae395639a1a2'
```

4. ローカル  
Jupyter Notebookに接続する
- ブラウザで[localhost:8888](http://localhost:8888)にアクセスし設定したパスワードを入力
- またはVisual Studio CodeのJupyter Extensionを使用してExistingを選択し、URLとして`http://localhost:8888`を指定する。同様にパスワードを入力
- `docker exec -it ${コンテナ} /bin/bash`でbashの対話環境を開ける。

