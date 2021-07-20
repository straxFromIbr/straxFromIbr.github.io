---
title: "Emacsでvimキーバインディング"
date: 2021-07-20T15:20:15+09:00
categories:
- プログラミング
- 環境構築
tags:
- プログラミング
- 環境構築
- emacs
- vim
- evil

thumbnailImage: https://raw.githubusercontent.com/emacs-evil/evil/master/doc/logo.png
summary: Emacsでvimエディタ風のキーバインディングを有効にする。簡単

---
記号処理プログラミングの授業でLisp処理系としてEmacs Lispを使用しているのだけど、viの便利さにすっかり魅了されてしまったがために何か方法はないかと模索。macOSユーザなのにﾅﾝﾃﾞﾀﾞｲ(Macは標準のキーバインドがemacs風)

[`EVIL`](https://github.com/emacs-evil/evil)というプラグインを見つけたのでインストール方法をメモ。次のコードを`~/.emacs.d/init.el`に追記する。ちなみにこの記事は普通にVimで書いてる。パッケージ管理システムとして[`MELPA`](https://melpa.org/#/getting-started)というのを使用しているらしい。Vimでいうところのvim-plugなのかな？

```emacs lisp
;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
```

<!--more-->
