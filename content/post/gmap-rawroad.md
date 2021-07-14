---
title: "Google Maps APIで道路網の抽出"
date: 2021-07-14T18:07:28+09:00
categories:
- 卒研
- データセット作成
tags:
- プログラミング
- GoogleMapsAPI
keywords:
- tech
thumbnailImage: /images/gmap-rawroad/staticmap.png
#thumbnailImage: //example.com/image.jpg
summary: Google Maps APIを使用して道路網と衛星写真をセットで取得する。簡単

---
卒研のためのデータセット収集の手段としてGoogle Maps APIの使用を検討している。そのためのテストとして次のような地図の画像を取得した。

{{< image classes="fig-50" src="/images/gmap-rawroad/staticmap.png" >}}
{{< image classes="fig-50" src="/images/gmap-rawroad/staticmap-2.png" >}}

## 道路画像
Google Maps APIに登録しAPI Tokenを取得したあと次に示すURLをブラウザなどで開くと道路の画像が取得できる。
ポイントは`style`変数の設定。地図中の`road`要素の色を`0xFFFFFF`つまり黒に、`landscape`の色を一括して`0x000000`と白にし、そのほかのfeature,elementを全て不可視にしている。詳細は[公式ドキュメント:Styled Maps](https://developers.google.com/maps/documentation/maps-static/styling?hl=ja)に詳しい。

<!--more-->
```sh
url="https://maps.googleapis.com/maps/api/staticmap"\
"?center=${lat},${lng}"\
"&size=${size}"\
"&zoom=${scale}"\
"&maptype=roadmap"\
"&sensor=false"\
"&markers=null"\
"&style=feature:road|color:0xFFFFFF"\
"&style=feature:landscape|color:0x000000"\
"&style=feature:poi|visibility:off"\
"&style=feature:transit|visibility:off"\
"&style=feature:water|visibility:off"\
"&style=element:labels|visibility:off"\
"&key=${googleapikey}"\
```
以下パラメータの概略と上図における設定を記載。

| パラメータ名   | 説明                 | 上図での設定  |
| :------------- | :------------------- | :------------ |
| `lat`          | 緯度                 | `36.5382486`  |
| `lng`          | 経度                 | `140.5307574` |
| `size`         | 画像の大きさ         | `670x670`     |
| `scale`        | 地図の縮尺           | `16`          |
| `googleapikey` | Google APIのトークン | 略              |


## 衛星写真
スタイル適用がない点と`maptype`が`satelite`となってることを除けば道路画像取得と同じ。またパラメータの設定も同じ。

```sh
url="https://maps.googleapis.com/maps/api/staticmap"\
"?center=${lat},${lng}"\
"&size=${size}"\
"&zoom=${scale}"\
"&sensor=false"\
"&maptype=satellite"\
"&markers=false"\
"&key=${googleapikey}"
```

あとはアクセス上限を超えないようにデータをかき集めるだけ。
