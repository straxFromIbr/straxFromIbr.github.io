---
title: "fisher/tide@v5の変更点"
date: 2021-08-12T22:47:22+09:00
categories:
- プログラミング
- fish
tags:
- プログラミング
- fish
- シェルスクリプト
- 環境構築
#thumbnailImage: /images/tide-v5-change/
#thumbnailImage: //example.com/image.jpg
summary: ilanCosman/tideのバージョン5における変更点

---
本日8月12日にリリースされた[IlanCosman/tide v5.0.0](https://github.com/IlanCosman/tide/releases/tag/v5.0.0)でアップデート時の注意点と変更点をメモ
<!--more-->

# 注意点
- 今後は`main`ブランチが開発ブランチになるため`fisher`でインストールする際には次のようにタグを指定する。またアップデートする際にはアイコンや背景色、プロンプトアイテムリストなどの各種ユニバーサル変数は保存しておきましょう。アップデートする直前に`_tide`で始まる変数が全て消去されることを後から知り泣いた。
```
fisher install IlanCosman/tide@v5
```
# 変更点
- アップデートされた`_tide_item_vi_mode`は挿入モードの時に何も表示しません。モード切り替えのたびにプロンプトの長さが変わるのが嫌な人は(ワタシ)は書き換えましょう。その際一度ファイルのコピーを`fisher`の管理外のディレクトリに置き、`fish/functions`下にはリンクを貼るとアップデートの影響を受けないでしょう。または[straxFromIbr/autoload-fish-config](https://github.com/straxFromIbr/autoload-fish-config)プラグインで管理するのもアリアリのアリです(宣伝

- 従来はプロンプトに表示するためにtideアイテムの定義内でビルトインの`printf`コマンドを使用していましたが新たに`_tide_print_item`関数を使用するようになったみたいです。第一引数にアイテム名、第二引数に表示する内容を渡すことで、文字色、背景色の設定などを内部で処理してくれるようです。`set_color`入らず！
    

```bash
# Defined in ~/.config/fish/functions/_tide_item_conda_env.fish @ line 1
function _tide_item_conda_env
	if test $CONDA_DEFAULT_ENV
        _tide_print_item conda_env $tide_virtual_env_icon' '$CONDA_DEFAULT_ENV 
	end
end

```
ちなみにコレも`fisher install straxFromIbr/invisible-conda-name`でインストールできるのでAnaconda/MiniForgeなど使っている方々はぜひ！(また宣伝)

