---
title: "シェルコマンドでデータ分割"
date: 2021-08-03T11:01:39+09:00
categories:
- プログラミング
- シェルスクリプト
tags:
- プログラミング
- シェルスクリプト
- fish
#thumbnailImage: /images/shell-datasplit/
#thumbnailImage: //example.com/image.jpg
summary: "シェルコマンドでデータ分割"

---

次のように`concat`ディレクトリにはいってる`*.png`を`test`,`train`ディレクトリに8:2で分割する.

```
$ tree datasets_2108030001 -d
datasets_2108030001
├── concat
├── test
└── train
```

```
datasets_2108030001/concat/
├── concat_0.png
├── concat_1.png
~~~省略~~~
├── concat_9998.png
└── concat_9999.png

0 directories, 10000 files
```

次のコマンドを`datasets_2108030001/concat/`ディレクトリで実行して分割
```bash
ls | head -n8000 | xargs -J% cp % ../train/
ls | tail -n2000 | xargs -J% cp % ../test/
```

次のコマンドで重複がないか確認

```bash
diff (ls | sort|psub) (ls ../test/ ../train/| sort |psub)
# こんなような出力になる？
# 0a1,3
# >
# > ../test/:
# > ../train/:
```

<!--more-->
<!--{{< image classes="fancybox clear fig-100 center" src="/images/shell-datasplit/" title="">}}-->














