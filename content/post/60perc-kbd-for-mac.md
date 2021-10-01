---
title: "サードパーティ製外部キーボードをMacで使う際の必須設定"
date: 2021-10-01T09:38:39+09:00
categories:
- Mac
- ユーティリティ
tags:
- Mac
- ユーティリティ
- karabiner
- キーボード
keywords:
- Mac
- ユーティリティ
- karabiner
- キーボード
- tech
summary: "キーボードを使う際の個人的設定メモ"
---
Apple製Magic KeyBoardを使う際はあまり問題にならないが、Windows用に作られたキーボードを使用する際は、CmdキーとOptionキーの配置を多少工夫する必要がある。

60%キーボードの場合、ESCキーとバッククオート・チルダが同じキーにありFnキーで切り替える、という製品もよくある。シェルでは記号を、ViなどのエディタではESCを多用するためできるだけ別のキーであるほうが望ましい。

そのため次のように[pqrs-org/Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements)を使って設定する。

` .config/karabiner/karabiner.json`
<script src="https://gist.github.com/straxFromIbr/b06f6c6381d43e86ab28fc8b5692ce1c.js"></script>

大雑把に
- CapsLock+何か -> LeftCtrl
- CapsLock単体 -> ESC
- MacUSキーボードと同じようにCmdとOptキーを配置 
- 左Cmd単体 -> 英数
- 右Cmd単体 -> かな

のような設定。Caps Lockの位置にエスケープを配置できるのがなんちゃってVimmerにとって非常に嬉しい。


