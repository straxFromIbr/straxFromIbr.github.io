---
title: "[m1Mac]/usr/local/bin/brewを削除する"
date: 2021-07-04T09:57:22+09:00
categories:
- Mac
- 環境構築
tags:
- Mac
- m1Mac
- 環境構築
- homebrew
keywords:
- tech
thumbnailImage: /images/deletebrew/brew.jpg


summary: "Arm64用のHomebrewがリリースされるまで使っていたx86系のhomebrewを削除したのでメモ"

---

Arm64用のHomebrewがリリースされるまで使っていたx86系のhomebrew(`/usr/local/bin/brew')と`/opt/homebrew/bin/brew`が併存していたためx86系を削除したのでそのメモ．

{{< alert danger >}}
本記事はHomebrew自身とHomebrewでインストールされたコマンド，カスクなどを全て削除するものです．また公式のスクリプトに手を加えるため場合によってはやばいことになるかもしれませんのでご注意を．
{{< /alert >}}

<!--toc-->

# アンインストールスクリプトのダウンロード
[Homebrewの公式リポジトリ](https://github.com/homebrew/install#uninstall-homebrew)に記載されてるコマンドは __実行せずに__ 次のコマンドでスクリプトをインストールする．

```sh
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh > ./uninstall.sh
```

# スクリプトの編集
そのまま実行すると`/opt/homebrew/bin/`のbrewが削除されてしまうので，先ほどインストールしたuninstall.shを編集する．50行目あたりに次のような記述があるはず．
```bash
ostype=macos
if [[ "$(uname -m)" == "arm64" ]]; then
    homebrew_prefix_default=/opt/homebrew
else
    homebrew_prefix_default=/usr/local
fi
```
この部分を全てコメントアウトし，次のように`homebrew_perfix_default`の値を固定してしまう．

```bash
ostype=macos
#if [[ "$(uname -m)" == "arm64" ]]; then
#   homebrew_prefix_default=/opt/homebrew
#else
#   homebrew_prefix_default=/usr/local
#fi
homebrew_prefix_default=/usr/local
```

# `PATH`の編集
環境変数`PATH`から`/opt/homebrew/`などを削除しターミナルを再起動する．
`which brew`と実行して`/usr/local/bin/brew`のように削除したいbrewのパスが表示されればOK

# 実行結果の事前確認 
スクリプトuninstall.shには`-h`オプションで確認できるようにいくつかオプションが用意されている．
`-n`(または`--dry-run`)オプションをつけて実行すると実際には削除せず，どのファイルが削除されるかシミュレートしてくれる．次のようなコマンドを実行する．途中でパスワードの入力を求められる．

```bash
/bin/bash ./uninstall.sh -n
```
必要なファイル`/opt/homebrew`などが削除対象となっていないことを確認したら次のステップへ．

# 削除の実行
次を実行するだけ．完了までしばしかかる．またこちらも同様に`sudo`権限が必要なためパスワードの入力を求められる．
```bash
/bin/bash ./uninstall.sh 
```

# パスの再設定
`$PATH`に再度必要なパスを追加する．

以上です．
