---
title: "fishシェルの設定ファイル管理"
date: 2021-07-22T14:54:35+09:00
categories:
- プログラミング
- fish
tags:
- プログラミング
- fish
- シェルスクリプト

thumbnailImage: /images/fish-config/terminal.jpg
summary: 'fishシェルの設定ファイル管理'

---
[fish](https://fishshell.com)を使い始めてしばらくたち、プラグインも色々入れた結果、設定ファイルがふえに増えてしまった。

ちょっと見通しが悪いので個人的な設定ファイルも[fisher](https://github.com/jorgebucaran/fisher)でプラグインとして管理するようにしたのでメモ。

{{< image classes="fancybox clear fig-75 center" src="/images/fish-config/terminal.jpg" title="見通しの悪い設定ファイル群">}}

<!-- toc -->
# 環境
- fish, version 3.2.2
- fisher, version 4.3.0

# ディレクトリ構成
次のように`~/.config/fish`の下に`myconf`ディレクトリを作成した。場所はどこでもいいのだけどサブディレクトリとして`conf.d`と`functions`が`fisher`の仕様上必要。そのため`fish/config.fish`はそのままにしておく。
```tree
tree -d -I tide ~/.config/fish
.config/fish
├── completions
├── conf.d
├── functions
└── myconf
    ├── conf.d
    └── functions

6 directories
```

# 設定ファイルの移行, gitの初期化
`myconf/*`内に自分で作成した設定ファイルを移動する。

その後`myconf`ディレクトリで`git init`コマンドを実行。

ターミナルを再起動すると設定が反映されていないことがわかる。

# 設定ファイルのインストール
次の`fisher`コマンドで設定ファイルをインストールする。

`~/.config/fish/fish_plugins`にパスが追記され即座に設定が反映される。

```bash
fisher install ~/.config/fish/myconf
```

# 設定ファイルの自動再読み込み
これまで同様に、ファイルを変更するたびに自動で設定が読み込まれるようにしたい。
次のスクリプトを`~/.config/fish/config.fish`に追記。


{{< tabbed-codeblock "~/.config/fish/config.fish"   >}}
    <!-- tab fish -->
set -U _fish_myconf_dir $HOME/.config/fish/myconf

function _reload_myconf -e fish_prompt
    if status is-interactive
       set new_sha1sum ( cat $_fish_myconf_dir/.git/refs/heads/main )
       # set new_sha1sum (cat $_fish_myconf_dir/**/*.fish | sha1sum | awk '{print$1}')
       if test -z $_myconf_sha1sum
           echo 'config update'
           fisher update $_fish_myconf_dir > /dev/null &
           set -U _myconf_sha1sum $new_sha1sum
       else
           if test $_myconf_sha1sum != $new_sha1sum
               echo 'config update'
               fisher update $_fish_myconf_dir > /dev/null &
               set -U _myconf_sha1sum $new_sha1sum
           end
       end
   end
end
    <!-- endtab -->
{{< /tabbed-codeblock >}}

プロンプトが更新されるたびに`git`の`main`ブランチのハッシュ値を確認し、新たなコミットがあれば`fisher update`するという寸法である。`$new_sha1sum`を`(cat $_fish_myconf_dir/**/*.fish | sha1sum | awk '{print$1}')`と定義すれば`.fish`ファイルが変更されるたびに設定が更新される。どちらにするかはお好みで。

----
以上です。

