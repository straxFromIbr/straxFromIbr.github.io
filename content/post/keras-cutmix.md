---
title: "KerasでCutMixを実装する"
date: 2021-10-24T17:04:41+09:00
categories:
- 卒研
- データ拡張
tags:
- 卒研
- データ拡張
- 機械学種
- python
- tensorflow
- keras
keywords:
- 卒研
- データ拡張
- 機械学種
- python
- tensorflow
- keras
thumbnailImage: "/images/keras-cutmix/scrot.png"
summary: "公式チュートリアルを参考に、画像セグメンテーションでも使えるようにする。"

---

参照:[CutMix data augmentation for image classification](https://keras.io/examples/vision/cutmix/)

# 方針
- 同じ内容のデータセット(順番はシャッフルする)を2つ用意し、zipする。

## 擬似コード

こんな感じ
```
dataset_one = CreateDatasetFromDir('path')
dataset_two = CreateDatasetFromDir('path')
dataset_zipped = zip(dataset_one, dataset_two)

dataset_cutmix = dataset_zipped.map(CutMix)
```

# CutMixのコード
```python:cutmix.py
import tensorflow as tf


def set_consts(img_size: int):
    global IMG_SIZE
    IMG_SIZE = img_size


def sample_beta_distribution(size, concentration_0=0.2, concentration_1=0.2):
    gamma_1_sample = tf.random.gamma(shape=[size], alpha=concentration_1)
    gamma_2_sample = tf.random.gamma(shape=[size], alpha=concentration_0)
    return gamma_1_sample / (gamma_1_sample + gamma_2_sample)


# Impplement CUTMIX
@tf.function
def get_box(lambda_value):
    cut_rat = tf.math.sqrt(1.0 - lambda_value)

    # rw
    cut_w = IMG_SIZE * cut_rat
    cut_w = tf.cast(cut_w, tf.int32)

    # rh
    cut_h = IMG_SIZE * cut_rat
    cut_h = tf.cast(cut_h, tf.int32)

    # rx & ry
    cut_x = tf.random.uniform((1,), minval=0, maxval=IMG_SIZE, dtype=tf.int32)
    cut_y = tf.random.uniform((1,), minval=0, maxval=IMG_SIZE, dtype=tf.int32)

    two = tf.constant(2, dtype=tf.int32)
    boundary_x1 = tf.clip_by_value(cut_x[0] - cut_w // two, 0, IMG_SIZE)
    boundary_y1 = tf.clip_by_value(cut_y[0] - cut_h // two, 0, IMG_SIZE)
    bb_x2 = tf.clip_by_value(cut_x[0] + cut_w // two, 0, IMG_SIZE)
    bb_y2 = tf.clip_by_value(cut_y[0] + cut_h // two, 0, IMG_SIZE)

    target_h = bb_y2 - boundary_y1
    if target_h == 0:
        target_h += 1

    target_w = bb_x2 - boundary_x1
    if target_w == 0:
        target_w += 1
    return boundary_x1, boundary_y1, target_h, target_w


# @tf.function
def mixed_img(image1, image2, *bbox):
    boundary_x1, boundary_y1, target_h, target_w = bbox
    # image2からパッチを切り出す
    crop2 = tf.image.crop_to_bounding_box(
        image2, boundary_y1, boundary_x1, target_h, target_w
    )
    # crop2のオフセットでパディング
    image2 = tf.image.pad_to_bounding_box(
        crop2, boundary_y1, boundary_x1, IMG_SIZE, IMG_SIZE
    )

    # image1からパッチを切り出す
    crop1 = tf.image.crop_to_bounding_box(
        image1, boundary_y1, boundary_x1, target_h, target_w
    )
    # crop1のオフセットでパディング
    image1_pad = tf.image.pad_to_bounding_box(
        crop1, boundary_y1, boundary_x1, IMG_SIZE, IMG_SIZE
    )

    image1 = image1 - image1_pad
    image = image1 + image2
    return image


@tf.function
def cutmix(train_ds_one, train_ds_two):
    (ip_image1, tar_image1), (ip_image2, tar_image2) = train_ds_one, train_ds_two
    print(len(train_ds_one))
    print(type(train_ds_one))

    alpha = [0.25]
    beta = [0.25]

    # ベータ分布から値採取
    lambda_value = sample_beta_distribution(1, alpha, beta)

    # Bボックスの高さと幅のオフセット取得
    lambda_value = lambda_value[0][0]
    bbox = get_box(lambda_value)
    ip_image = mixed_img(ip_image1, ip_image2, *bbox)
    tar_image = mixed_img(tar_image1, tar_image2, *bbox)

    return ip_image, tar_image
```

データセット作成のコードとともにGistにあげてある。
[https://gist.github.com/straxFromIbr/d28a6e5ef4ae631378b078d6ed639122](https://gist.github.com/straxFromIbr/d28a6e5ef4ae631378b078d6ed639122)


![](/images/keras-cutmix/scrot.png)
