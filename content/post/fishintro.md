---
title: "Fish環境構築"
date: 2021-06-26T14:30:20+09:00
categories:
- プログラミング
- 環境構築
tags:
- fish
- シェルスクリプト
keywords:
- tech
thumbnailImage: /images/fishtide.jpg
autoThumbnailImage: true
summary: fishシェルへの乗り換え案内


#thumbnailImage: //example.com/image.jpg
---
前々からfishに乗り換えようと画策しておりついに重い腰をあげたので後学のためにメモ．きっと忘れるだろうから．
次の資料は要チェック．[全訳！fishシェル普及計画](http://fish.rubikitch.com)
<!-- toc -->
# 0. 現在の状況
- Homebrew 
  - バージョン：  
    Homebrew 3.2.0
    Homebrew/homebrew-core (git revision abe8183868; last commit 2021-06-25)
    Homebrew/homebrew-cask (git revision a14b80214e; last commit 2021-06-25)
  - パス：`/opt/homebrew/bin/brew`

# 1. fishのインストール
Homebrew 経由でインストールする．またデフォルトのシェルをfishにする．
```sh
$ brew install fish
$ echo $(which fish) | sudo tee -a /etc/shells
$ chsh -s $(which fish)
```
完了したらTerminalアプリを再起動．

# 2. パスの設定
この項目は人によっては不要．
fishはzshなどと違い`~/.config/fish/*.fish`がログイン時に全て実行されるので，zshやbashのように`~/.{bash, zsh}rc`で`source`コマンドで明示的に呼び出さなくてもいい．brewのパスを追加するために`~/.config/fish/conf.d/path.fish`を作成し次のように書く．
```sh
set -x PATH /opt/homebrew/bin $PATH
```

# 3. miniforge(conda)の設定
fishシェル内で
`conda init fish`を実行．先程の`~/.config/fish/conf.d`に`conda.fish`が生成されるはず．

# 4. プラグインマネージャーのインストール
fishはデフォルトでもシンタックスハイライトやヒストリ補完をしてくれるのがうまみだが，さらに便利にするためにプラグインマネージャ[fisher](https://github.com/jorgebucaran/fisher)をインストール．詳しくはリンク参照．とりあえず次のコマンドを実行し，バージョン確認．
```sh
$ curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
$ fisher --version # fisher, version 4.3.0
```
# 5. テーマの設定
個人的な趣味で`Powerline`っぽいテーマの[tide](https://github.com/IlanCosman/tide)をインストール．
```sh
$ fisher install IlanCosman/tide
$ tide configure
```
こんな具合
{{< image classes="fancybox clear fig-100 center" src="/images/fishtide.jpg"   group="group:bike"  title="fishシェル" >}}

# 6. ログインスクリプトの移行
同様に`~/.config/fish/conf.d`に記述．`if`文やコマンド展開`$()`の文法がPOSIXシェルと所々違うので注意．

# 7. 課題
- 現状，`python3`のパスが`brew`でインストールされたものになってしまう．設定ファイルの読み込まれる順番の調査．
今はこのように対処．
```sh
set -x PATH /opt/homebrew/bin $PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval ~/miniforge3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
```
