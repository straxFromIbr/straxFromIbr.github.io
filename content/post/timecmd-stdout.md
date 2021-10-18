---
title: "[Bash] timeコマンドの計測結果だけを標準出力に流す"
date: 2021-10-18T21:11:31+09:00
categories:
- プログラミング
- シェルスクリプト
tags:
- プログラミング
- シェルスクリプト
- bash
- linux
keywords:
- プログラミング
- シェルスクリプト
- bash
- linux
- tech


summary : "もとのコマンドの結果は破棄し、timeコマンドの計測結果だけを標準出力に流す"

---

# 解決策：
```bash
(time ${some_command} 1>/dev/null 2>&1)  2>&1 
```

# 例
`test.sh`：標準エラーにhello、標準出力にworldを出力する。
```bash
#!/bin/bash
echo hello 1>&2
sleep 1
echo world
```
./test.shの標準出力をNullデバイスにリダイレクトし、エラーを表順出力(つまりNullデバイス)にリダイレクトする。そしてtimeコマンドのエラー出力を標準出力にリダイレクトする。これはNullデバイスを指さない。かっこの位置に注目。
```bash
(time ./test.sh 1>/dev/null 2>&1)  2>&1 | tee result.txt
```
結果はつぎのようになる。
`result.txt`
```
real	0m1.423s
user	0m0.002s
sys	0m0.008s
```
