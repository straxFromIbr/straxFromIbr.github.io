---
title: "fishのプロンプトにCondaの環境名を表示しないようにする"
date: 2021-07-21T18:02:22+09:00
categories:
- プログラミング
- シェルスクリプト
tags:
- プログラミング
- シェルスクリプト
- fish
- friendly-interactive-shell

thumbnailImage: /images/tide-erase-condaname/prompt.jpg
summary: "fishのプロンプトにCondaの環境名を表示しないようにする"

---
fishのオシャレなプロンプトフレームワークである[llanCosman/tide](https://github.com/IlanCosman/tide)でMiniForge[コンダ環境の名前をプロンプトに表示](https://straxfromibr.github.io/2021/06/fish_tide/)するようにした... のだがデフォルトの表示も残ってしまいイマイチダサいプロンプトになってたので修正。

手っ取り早く適用したい人は[jorgebucaran/fisher: A plugin manager for Fish.](https://github.com/jorgebucaran/fisher)をインストールしたあと次のコマンドを実行。

結構手軽にプラグインが作成できてびっくりした。

```
fisher install straxFromIbr/invisible-conda-name
```

{{< image classes="fancybox clear fig-100 center" src="/images/tide-erase-condaname/prompt.jpg" title="プロンプト">}}

変数の一覧から次のようにしてconda環境名を設定してそうな変数を調べると・・・
```bash
> set | grep base | grep -v history
CONDA_DEFAULT_ENV base
CONDA_PROMPT_MODIFIER '(base) '
```
表示に関わっていそうなのは`$CONDA_PROMPT_MODIFIER`であることがわかる。
そのためこの変数を次のコマンドで削除する

```bash
set -e CONDA_PROMPT_MODIFIER
```
するとプロンプト右下の`(base)`という表示が消えるはず。

このコマンドを毎度打つのも非常に手間なのでfishシェルの機能であるイベントハンドラを用いて解決する。次のような関数を適当な`~/.config/fish/*.fish`ファイルに定義する。関数名も適当でいい。`_`を先頭につけると`functions`コマンドで表示されない不可視関数として定義できる。

この関数でキモとなるのは`-e fish_prompt`オプションである。これは新たなfishプロンプトが表時される直前に発生するイベント`fish_prompt`時に関数を自動的に実行させるためのオプションである。エンターキーを押すたびに変数を削除するわけですね。

参考:[function - create a function — fish-shell 3.3.1 documentation](https://fishshell.com/docs/current/cmds/function.html?highlight=function)
```bash
function _clear_condaenvname -e fish_prompt
    set -e CONDA_PROMPT_MODIFIER
end
```

おしまい


<!--more-->


