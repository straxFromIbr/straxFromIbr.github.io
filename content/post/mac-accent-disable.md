---
title: "[Mac]キーボードのアクセントメニューを無効化"
date: 2021-07-03T17:43:40+09:00
categories:
- Mac
- 環境構築
tags:
- Mac
- 環境構築
- 備忘録

thumbnailImage: /images/mac-accent-disable/accmenu.jpg
summary: キーボードのアクセントメニューを無効にするためのコマンド．備忘録．

---
`i`などのようにアクセント記号やティルデがつくアルファベットを長押しした時，次のようなアクセントメニューが表示されてしまう．Vim系のキーバインドのアプリケーションを使う時とてもとても不便なのでなんとか無効にしたい(iTermでは表示されない)．
{{< image classes="fancybox clear fig-100 center" src="/images/mac-accent-disable/accmenu.jpg" title="アクセントメニュー" >}}

ググると次の記事を見つけたので試してみたらうまくいった．

[Mac で 英語入力時にアクセント文字のポップアップを非表示にする方法](https://yasuharu519.hatenablog.com/entry/2016/05/02/085639)


```bash
defaults write -g ApplePressAndHoldEnabled -bool false
```
端末アプリ(ターミナルなど)で上記のコマンドを実行したあと， 再起動または再ログインで適用する．
なんで設定.appで設定できないの...?


以上です．相変わらず中身のないブログだ．
