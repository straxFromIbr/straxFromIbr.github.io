---
title: "Yolov5 on Jetson"
date: 2021-08-31T11:00:15+09:00
categories:
- 機械学習
- Jetson
tags:
- 機械学習
- jetson
- pytorch
- yolov5
keywords:
- tech

summary: 'YoloV5をJetson Nanoで動かせるようにする。'


---

# Torchvisionのインストール
[https://qengineering.eu/install-pytorch-on-jetson-nano.html](https://qengineering.eu/install-pytorch-on-jetson-nano.html)

PyTorch 1.7.0
ビルド済みのwheelがGoogle Driveにアップロードされているためそれを使用。
```bash
sudo apt install libjpeg-dev zlib1g-dev libpython3-dev
sudo apt install libavcodec-dev libavformat-dev libswscale-dev
python3 -m pip install -U pillow gdown
gdown https://drive.google.com/uc?id=1WhplBjODLjNmYWEvQliCdkt3CqQTsClm
python3 -m pip install torchvision-0.8.1a0+45f960c-cp36-cp36m-linux_aarch64.whl
```

# Seabornのインストール
```bash
sudo apt install python3-seaborn
```
`pip`ではなく`apt`でインストールする。依存している`matplitlib`も同時にインストールする。はいらない場合は`apt`で`python3-matplotlib`パッケージをインストールする。

<!--more-->
<!-- {{< image classes="fancybox clear fig-100 center" src="/images/yolov5-on-jetson/" title="">}} -->
