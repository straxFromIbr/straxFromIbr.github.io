---
title: "Prolog week9"
date: 2021-06-23T11:43:32+09:00
categories:
- LectureNote
- 知識情報処理
tags:
- Prolog
- 知識情報処理
- 授業メモ

summary: 知識情報処理 9週
thumbnailImagePosition: "buttom"

---


## 述語の解説
- `reverse`
	- リストの要素を逆順にする述語.
	- `?- reverse([1,2,3,4,5], R).` -> `R = [5,4,3,2,1].`
- `member`
	- 要素がリストに含まれいているかを判定する．
	- `?- member(3, [1,2,3,4,5]).` -> `true`

## 演習
次のグラフを表現し，経路A->Oについて求めろ．
``` prolog
隣接(a, d).
隣接(a, b).
隣接(b, e).
隣接(e, g).
隣接(e, f).
隣接(c, f).
隣接(f, h).
隣接(h, i).
隣接(h, k).
隣接(h, l).
隣接(l, o).
隣接(n, o).
隣接(k, n).
隣接(k, j).
隣接(j, m).
隣接(j, g).


隣接点(X, Y) :- 隣接(X, Y).
隣接点(X, Y) :- 隣接(Y, X).

経路探索(Y, Y, A) :- 
	reverse([Y | A], A0),
	write(A0), nl, !, fail.

経路探索(X, Y, A) :-
	not(member(X, A)),
	隣接点(X, N),
	経路探索(N, Y, [X | A]).
```
- 実行
	- `?- 経路探索(a, o, []).` 
	- 
	

