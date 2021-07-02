---
title: "systemdでGUIアプリケーションを自動実動"
date: 2021-07-02T20:44:03+09:00
categories:
- プログラミング
- RaspberryPi
tags:
- RaspberryPi
- Linux
keywords:
- tech
thumbnailImage: /images/piservice/
#thumbnailImage: /images/piservice/
#thumbnailImage: //example.com/image.jp
summary: "systemdによりRasPiを起動した際にスクリプトを自動実行するようにするための概略メモ"

---
systemdによりRasPiを起動した際にスクリプトを自動実行できるようにするための設定についてメモ．詳しくはmanページなどを参照のこと．
次の記事を参考にした．[Systemdを使ってchromium-browserを自動起動](https://qiita.com/takanemu/items/c2982bfb74c72cbf174d)

<!-- toc -->

# 実行するアプリケーションの概要
デスクトップ画面を使用するGUIアプリケーションを起動する．そのため`raspi-config`でデスクトップへの自動ログインを有効にしておく．

# Unitファイルの作成
次のようなファイルを`/etc/systemd/system/${サービス名}.service`として保存する．ここではサービス名を`guiapp.service`としておく．
見ての通り`Description`でサービスの説明，`User`で実行権限，`Environment`でディスプレイを使用する旨の設定，`ExecStart`でアプリケーションの実行に必要なスクリプトファイルのパスを指定する．またこのファイルの実行権限は`User`で指定したものと同じにしておく．


```service
[Unit]
Description=launch guiapp

[Service]
User=pi
Environment=DISPLAY=:0
ExecStart=/home/pi/rungui.sh

[Install]
WantedBy=user@.service
```

# サービスの登録
次のコマンドでサービスを登録する．これでシステムを再起動するとスクリプトが自動で実行されるようになるはず．

```bash
sudo systemctl enable guiapp.service
```

あるいは次のようにして即時に起動できる．

```bash
sudo systemctl start guiapp.service
```


