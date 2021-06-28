---
title: "HammerSpoon小ネタその1"
date: 2021-06-27T23:27:45+09:00
categories:
- ユーティリティ
- hammerspoon
tags:
- プログラミング
- lua
- hammerspoon

summary: URLエンコーディングのショートカットを作成

---

日本語など非ASCII文字を含むURLをTwitterで共有するとき，非ASCII文字はURLとして認識されない．
Webにはブラウザ経由で使用できる[ツール](https://tech-unlimited.com/urlencode.html)があるがわざわざアクセスするのも至極面倒なので，[hammerspoon](https://www.hammerspoon.org)でショートカットキーを作成した．hammerspoonは便利．Lua言語必須だけど．

作成には次の資料を参考にした.
- [HammerSpoon API documentation hs.pasteboard](https://www.hammerspoon.org/docs/hs.pasteboard.html#setContents)
- [PythonでURLエンコード・デコード](https://note.nkmk.me/python-urllib-parse-quote-unquote/)
- [luaでlinuxのコマンドを実行する](https://qiita.com/hidetzu/items/623cec2ec171db57c246)


次のように使用する
1. ⌘C で変換対象URLをコピー
1. ⌥⌃U (Opt-Ctrl-U)でコピーしたURLをエンコードしクリップボードに保存
1. ⌘V でペースト 

例えば次のように変換される．
`https://straxfromibr.github.io/2021/06/fish環境構築/` -> `https://straxfromibr.github.io/2021/06/fish%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89/`

実際のエンコードの処理はPythonの標準ライブラリ`urllib`を使用してる．
Python万歳．Luaが分かればLuaで書いてた．

以下がスクリプト．`~/.hammerspoon/init.lua`に追記する．詳しくは[公式ドキュメント](https://www.hammerspoon.org)を参照のこと．


{{< tabbed-codeblock "~/.hammerspoon/init.lua"   >}}
    <!-- tab lua -->
 -- URL encoding
 hs.hotkey.bind({"alt", "ctrl"}, "U", function()
	 local url= hs.pasteboard.readString()
	 local cmd = "/usr/bin/python3 -c \"import urllib.parse as p; print(p.quote('" .. url .. "', safe=':/'))\""
	 local handle = io.popen(cmd)
	 local result = handle:read("*a")
	 hs.pasteboard.setContents(result)
 end)

    <!-- endtab -->
{{< /tabbed-codeblock >}}
