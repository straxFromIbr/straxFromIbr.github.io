---
title: "hugoとGithub Pagesでブログ作成"
date: 2021-06-23T23:05:56+09:00
categories:
- ブログ(hugo)
- 構築

tags:
- hugo
- ブログ構築
thumbnailImage: /images/hugo.jpg
thumbnailImagePositionL: "top"
summary: hugoでブログの作成とGitHub Pagesへのアップロード
# coverImage: /images/hugo.jpg
# metaAlignment: center

---
この数ヶ月間，ちょっとしたメモのうち有用だと思われるものは[note](https://note.com/straxfromibr)で公開していたのだが，なんだか痒いところに手が届かないというか使いづらかったので移行を検討中．


<!-- toc -->

公式の手順に沿って進めればなんの問題もないが，今後のためにメモ．
# 現在の環境
- hugo v0.84.0+extended darwin/arm64 BuildDate=unknown

# 1. hugoのインストール  
` $ brew install hugo`
# 2. ブログページをローカルに作成．

MyBlogという名前でブログのルートディレクトリを作成．
適当なディレクトリで次を実行．以降，ルートディレクトリ(`/`)を`MyBlog/`とする．
```sh
$ hugo new site MyBlog && cd MyBlog
$ git init
```

# 3. テーマの選定とインストール．
ここでは[Tranquilpeak](https://github.com/kakawait/hugo-tranquilpeak-theme)を選択したことを前提にする．  
submoduleとしてテーマをインストールする．またテーマに同梱されるconfigファイルを叩き台に設定ファイルを作成
ディレクトリ`/`で次を実行．この段階でビルドし開発サーバーを起動できるはず．
```sh
$ mkdir themes && cd themes
$ git clone https://github.com/kakawait/hugo-tranquilpeak-theme.git 
$ cd ..
$ cp themes/tranquilpeak/exampleSite/config.toml .
$ hugo -D server
```
        
# 4. config.tomlの編集
[公式のチュートリアル](https://github.com/kakawait/hugo-tranquilpeak-theme/blob/master/docs/user.md)を見て進める．長いので割愛．  
当ブログの設定ファイルはこちらの[リンク](https://github.com/straxFromIbr/straxFromIbr.github.io/blob/main/config.toml)．

# 5. 記事の作成
hugoのコマンドでタイムスタンプなどのメタデータ（Front Matter)が記述されたMarkDownが生成される．それを直接編集する．
```sh
$ mkdir content
$ hugo new post/hugotutorial.md
$ cd content/post
$ vi hugotutorial.md
```
# 6. Github Pagesへのアップロード
hugoでブログを出力するディレクトリを`MyBlog/docs`にし，それを公開することにする．

   1. Github Pagesを設定したリポジトリを作成する．そのドキュメントルートを`docs`としMyBlogのリモートオリジンに紐付ける．
        ```
        $ git remote add origin https://github.com/<yourname>/<reponame>.git
        ```
   2. `MyBlog/config.toml`を書き換え，次の行を追加．このブログの場合はbaseURLは`https://straxfromibt.github.io`である．

        ```
        baseURL = "https://<username>.github.io/{<reponame>}"
        publishDir = "docs
        ```
   3. ブログをビルドし，変更内容をプッシュする．  
        
        ```
        $ hugo -D
        $ git add -A
        $ git commit -m "ブログ始めました"
        $ git push origin main
        ```
しばらくすると公開されてるハズ．

# 7.補足
## 画像の扱い
このテーマの製作者は記事内で画像を扱うときはCloudinaryなどのCDNサービスを使うことを推奨している．一方同一のリポジトリ内で保存した画像を使用する時には，`content/imgaes`ディレクトリを作成し記事ファイル内で`/images/img.jpg`などのように相対ぱすで指定する．
## 目次の表示(Table of contents)
[このissue](https://github.com/kakawait/hugo-tranquilpeak-theme/issues/395)を参考に，次の記述を`config.toml`に追加．
``` toml
[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true
    [markup.tableOfContents]
      endLevel = 3
      orderd = true
      startLevel = 1
```
そしてブログ記事内で目次を表示したい部分に`<!-- toc -->`を挿入する．
当記事の[ソースコード](https://raw.githubusercontent.com/straxFromIbr/straxFromIbr.github.io/main/content/post/hugotutorial.md)も参考になるかも．
{{< image classes="fancybox clear fig-100 center" src="/images/hugo.jpg"   group="group:bike"  title="hugoによるブログの外観" >}}