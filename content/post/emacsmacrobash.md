---
title: "Emacs Lispのマクロ定義のあの記号はbashでいうアレ"
date: 2021-07-21T16:04:24+09:00
categories:
- プログラミング
- lisp
tags:
- プログラミング
- lisp
- シェルスクリプト
- bash
#thumbnailImage: /images/emacsmacrobash/
#thumbnailImage: //example.com/image.jpg
summary: Emacs Lispのマクロ定義の記号とbashのコマンド展開の(無理のある）対応付け。

---

Emacs Lispのマクロ定義の記号とbashのコマンド展開の(無理のある）対応付け。正確性を犠牲にして分かりやすさを優先してる。

`$ `以降が標準入力、`> `以降が標準出力。
```bash
$ ls  ## ふつうにS式を解釈することと対応
> testfile1 testfile2 testfile3
$ echo '$(ls)' ## シングルクオートを先頭につけることと同等。`$(ls)`が文字列として`echo`に渡される。
> $(ls)
$ echo "$(ls)"  ## バッククオートに対応。`"`で囲まれた部分が評価され`echo`に渡される。
> testfile1
> testfile2
> testfile3
```


