---
title: "Python環境構築 on RasPi"
date: 2021-06-28T20:53:20+09:00
categories:
- プログラミング
- RaspberryPi
- Python
tags:
- RaspberryPi
- Python
- TensorFlow
- 環境構築
- 備忘録
keywords:
- tech
#thumbnailImage: //example.com/image.jpg
summary: RaspberryPi4上にTensorflowなど各種ライブラリをインストールする．
---
RaspberryPi4上にTensorflowなど一手間かかるライブラリをインストールする方法を記載．ほとんどはWeb上の資料を参考にした．リンクは適宜貼っているので詳しくはそちらを参照．

```
pi@raspberrypi:~ $ uname -a
Linux raspberrypi 5.10.17-v7l+ #1421 SMP Thu May 27 14:00:13 BST 2021 armv7l GNU/Linux
```

<!-- toc -->

# Edge TPU runtime 
- 公式チュートリアル[Get started with the USB Accelerator](https://coral.ai/docs/accelerator/get-started/#3-run-a-model-on-the-edge-tpu)に従う．Coral Edge TPUは取り外した状態で操作を行うこと！全てインストールが完了したら接続しテストする．
```bash
echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/$ coral-edgetpu.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install libedgetpu1-std
# sudo apt-get install libedgetpu1-max #高速化を図りたい時．熱に注意
sudo apt-get install python3-pycoral
```


# OpenCV
[RaspberryPiへのOpenCVインストール手順](https://qiita.com/wk_/items/8db529a6b24a955888db)と[【Raspberry Pi】Raspberry Pi Zero WにOpenCVの環境を構築する](https://rikoubou.hatenablog.com/entry/2019/05/21/151337)を参考にした．ありがとうございます．
```bash
sudo apt-get update
sudo apt install libavutil56 libcairo-gobject2 libgtk-3-0 libqtgui4 libpango-1.0-0 libqtcore4 libavcodec58 libcairo2 libswscale5 libtiff5 libqt4-test libatk1.0-0 libavformat58 libgdk-pixbuf2.0-0 libilmbase23 libjasper1 libopenexr23 libpangocairo-1.0-0 libwebp6
sudo apt-get install libatlas-base-dev libjasper-dev qt4-dev-tools qt4-doc qt4-qtconfig libqt4-test
pip3 install opencv-python
echo 'export LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libatomic.so.1' >> ~/.bashrc
```
環境変数`LD_PRELOAD`の設定が必要．サブシェル内で`cv2`ライブラリをインポートするPythonファイルを実行するときも同様な記述が必要．例えば次のようになる．

```bash
export LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libatomic.so.1
/usr/bin/python3 some_scripts_uses_cv2.py
```

# Pillow

`python3 -m pip install Pillow`とすることで`PIL`中の`Image`は使用できたが`ImageTk`は使用できなかった．ググると次のを見つけたので愚直に従う．[Cannot import ImageTk](https://www.raspberrypi.org/forums/viewtopic.php?t=210360#p1299309)
元記事では`sudo`で実行していたがバクゼンとした恐怖があるのでユーザ権限で実行．支障はなかった．
```bash
pip3 install pillow --upgrade 
```

# Matplotlib

`pip`経由でインストールしたところインポートでエラーが発生したため調べたところ「[Raspberry PiのPythonライブラリはpipよりapt-getで入れるのが断然早い](https://karaage.hatenadiary.jp/entry/2018/10/05/073000)」をはじめ各所で`apt`でのインストールを推奨していたのでそれで試行．うまくいった．

```bash
sudo apt-get install python3-matplotlib
```


  

