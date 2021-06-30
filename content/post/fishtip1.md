---
title: "Fish tideのアイテム追加"
date: 2021-06-29T22:56:22+09:00
categories:
- プログラミング
- シェルスクリプト
tags:
- fish
- tide
- シェルスクリプト

keywords:
- tech
#thumbnailImage: /images/fishtip1/
#thumbnailImage: //example.com/image.jpg
summary: "Fishシェルのプロンプトプラグインtideの設定について"
---
fishシェルのオシャレで高機能なプトンプトテーマ[tide](https://github.com/IlanCosman/tide)の設定備忘録です．
ユーザードキュメントを読んだ方が早いかもしれませんが．
<!--toc-->

# tideの構造
`tide`プロンプトに表示される要素は左右それぞれ，`$tide_left_prompt_items`, `$tide_right_prompt_items`にリスト形式で格納されています．  
例えば次のプロンプトの場合，`$tide_left_prompt_items`の値は`os pwd git newline`となっています．

{{< image classes="fancybox clear fig-100 center" src="/images/fishtip1/mytide_left.jpg" title="$tide_left_prompt_items">}}

`os`や`git`など各要素は`_tide_item_$要素名`関数として定義されます．例えば`os`は`_tide_item_os`であり，そのままプロンプとに入力し実行するとOSのアイコンが表示されます．また`functions`コマンドでソースコードを確認すると，`~/.config/fish/functions/`ディレクトリに保存されていることがわかります．

{{< image classes="fancybox clear fig-100 center" src="/images/fishtip1/funcos.jpg" title="_tide_item_os" >}}

# 自作関数の追加


<!--more-->
