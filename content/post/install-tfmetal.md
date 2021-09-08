---
title: "M1 Mac にTensorFlow v2.5をインストール"
date: 2021-09-08T21:51:26+09:00
categories:
- 機械学習
- tensorflow
tags:
- 機械学習
- tensorflow
- python
- m1
keywords:
- tech
#thumbnailImage: /images/install-tfmetal/
#thumbnailImage: //example.com/image.jpg

summary: "M1 Mac にMetalアクセラレーションのTensorFlow 2.5をインストールする"


---
M1版のTensorFlowの開発状況がふときになって[apple/tensorflow_macos](https://github.com/apple/tensorflow_macos)を覗いたらアーカイブされてた。しれっとMetalがサポートされたTensorFlowがリリースされてたのでインストールしてみた。

<!--toc-->

# 環境
- M1 Mac
- macOS 12.0 Beta 5
- conda 4.10.3 (MiniForge) 

# TensorFlowのインストール
基本的に[公式ドキュメント](https://developer.apple.com/metal/tensorflow-plugin/)に従えば問題ない(ハズ

## [MiniForge](https://github.com/conda-forge/miniforge)のインストール
[ココ](https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh)からM1アーキテクチャようのMiniForgeインストーラをダウンロードし、実行権限を与えて実行。途中いくつか質問されるがすべてyesかリターンで可。

```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
chmod +x  MiniForge3-MacOSX-arm64.sh
sh ~/Downloads/Miniforge3-MacOSX-arm64.sh
source ~/Downloads/Miniforge3-MacOSX-arm64.sh
```

fishを使用しているひとは最後の行を`bass source ~/Downloads/Miniforge3-MacOSX-arm64.sh`とすれば問題ないはず。


## Conda環境の作成とTFのインストール

Python 3.8,9をサポートしているためそのようにバージョンをしていして環境を作成する。 ここでは3.8系の環境`mactf`を作成。

```bash
conda create --name mactf python=3.8
conda activate mactf
```

依存パッケージをインストールし、TensorFlow、TensorFlow-Metalをインストール。
```bash
conda install -c apple tensorflow-deps
python -m pip install tensorflow-macos
python -m pip install tensorflow-metal
```
## インポートできるかテスト
どうやらMetalプラグインを正常に読み込めてるみたい。

```python
>>> import tensorflow as tf
Init Plugin
Init Graph Optimizer
Init Kernel
>>> tf.__version__
'2.5.0'
>>>
```

おしまい。ベンチマークとかもとってalpha版と比較してみたい。













