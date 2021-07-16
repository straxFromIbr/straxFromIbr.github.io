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
thumbnailImage: /images/fishtip1/shlvl.jpg
# coverImage: /images/fishtip1/mytide_left.jpg
summary: "Fishシェルのプロンプトプラグインtideの設定について"
---

## 追記(2021/07/16 21:38)
> 関数を定義するファイルは`~/.config/fish/conf.d`内でも`~/.config/fish/functions`内のどちらでもよく、またファイル名も任意で良いみたいです。

fishシェルのオシャレで高機能なプロンプトテーマ[tide](https://github.com/IlanCosman/tide)の設定備忘録です．
ユーザードキュメントを読んだ方が早いかもしれませんが．
<!--toc-->

# tideの構造
`tide`プロンプトに表示される要素は左右それぞれ，`$tide_left_prompt_items`, `$tide_right_prompt_items`にリスト形式で格納されています．  
例えば次のプロンプトの場合，`$tide_left_prompt_items`の値は`os pwd git newline`となっています．

{{< image classes="fancybox clear fig-100 center" src="/images/fishtip1/mytide_left.jpg" title="$tide_left_prompt_items">}}

`os`や`git`など各要素は`_tide_item_$要素名`関数として定義されます．例えば`os`は`_tide_item_os`であり，そのままプロンプとに入力し実行するとOSのアイコンが表示されます．また`functions`コマンドでソースコードを確認すると，`~/.config/fish/functions/`ディレクトリに`_tide_item_$関数名.fish`という名前のファイルで保存されていることがわかります．  
さらにこれらの関数は{{< hl-text warning >}} 子プロセスで実行{{< /hl-text >}}されます．そのためconda環境の名前などシェル起動時に初期化される変数を表示したい場合には一工夫必要です．  
(`eval $HOME/miniforge3/bin/conda ~~~~`の実行を`$SHLVL`が1の時のみにするなど)

{{< image classes="fancybox clear fig-100 center" src="/images/fishtip1/funcos.jpg" title="_tide_item_os" >}}

# 自作関数の追加

## 1. 関数の作成  
ここでは`$SHLVL`が2以上の時プロンプト右側に表示するアイテムを作成します．次のような関数`_tide_item_shlvl`を`~/.config/fish/functions/_tide_item_shlvl.fish`に作成します．
<<追記>>
ファイル名は*任意で可*

{{< tabbed-codeblock "~/.config/fish/functions/_tide_item_shlvl.fish"   >}}
    <!-- tab fish-->
# Defined in ~/.config/fish/functions/_tide_item_shlvl.fish @ line 1
function _tide_item_shlvl  
    if test $SHLVL -ge 3
        set_color 000000
        printf '%s' '@'(math $SHLVL - 1)
    end
end
    <!-- endtab -->
{{< /tabbed-codeblock >}}

上記の関数のポイントです．
- `_tide_item_`から関数名を始める．
- ファイル名は関数名と同じにする．
- 関数の標準出力がプロンプトに表示される．
- 関数は{{< hl-text warning >}} 子プロセスで実行{{< /hl-text >}}される．(そのため`printf`で表示する`SHLVL`は関数が実行されるシェルで参照される値から1を減じています．)

## 2. 背景色の設定
次のコマンドを実行し，`SHLVL`が表示される部分の背景色を設定します．第2引数は色の名前，もしくは`EEEEEE`のようにRGB値で指定します．`-U`オプションはユニバーサル変数を設定するためのものです．fishにおけるユニバーサル変数とはファイルに書き込まれ明示的に削除されない限り永続する変数のことです．[参照](https://fishshell.com/docs/current/tutorial.html#universal-variables)
```
set -U tide_shlvl_br_color yellow
```

## 3. プロンプトへの登録
次のコマンドで`tide_right_prompt_items`というリスト変数の末尾に作成した`shlvl`を追加します．`-a`オプションはリスト変数の末尾に第2引数を追加することを示します．Pythonでのリストオブジェクトの`.append()`メソッドと同様ですね．
```
set -a tide_right_prompt_items shlvl
```

## 4. 動作確認
`fish -l`と実行してみましょう．プロンプトの右側に`@2`と表示されているはずです．(以下の写真では[Nerdfont](https://www.nerdfonts.com)を使用してターミナルのアイコンを表示しています．)

{{< image classes="fancybox clear fig-100 center" src="/images/fishtip1/shlvl.jpg" title="shlvl" >}}


以上です．
