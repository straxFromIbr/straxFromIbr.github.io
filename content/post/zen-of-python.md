---
title: "Zen of Python ~Pythonの悟り~"
date: 2021-09-15T22:19:00+09:00
categories:
- プログラミング
- python
tags:
- プログラミング
- python
- 標準ライブラリ
- ポエム
keywords:
#thumbnailImage: /images/zen-of-python/
#thumbnailImage: //example.com/image.jpg

summary: "Pythonの真髄ここにあり。"
---
Pythonの標準モジュール`this.py`にはTim Peter氏によるPythonの、プログラマとしての心構えが記されている。


# 原文 Tim Peters
>```text
>$ python3 -m this
>The Zen of Python, by Tim Peters
>
>Beautiful is better than ugly.
>Explicit is better than implicit.
>Simple is better than complex.
>Complex is better than complicated.
>Flat is better than nested.
>Sparse is better than dense.
>Readability counts.
>Special cases aren't special enough to break the rules.
>Although practicality beats purity.
>Errors should never pass silently.
>Unless explicitly silenced.
>In the face of ambiguity, refuse the temptation to guess.
>There should be one-- and preferably only one --obvious way to do it.
>Although that way may not be obvious at first unless you're Dutch.
>Now is better than never.
>Although never is often better than *right* now.
>If the implementation is hard to explain, it's a bad idea.
>If the implementation is easy to explain, it may be a good idea.
>Namespaces are one honking great idea -- let's do more of those!
>```



## 拙訳

### Pythonの悟り   
美しくあることは、醜くあることより優れている。  
明示的であることは、暗黙的であることより優れている。  
単純であることは、複雑であることより優れている。  
複雑であることは、煩雑であることより優れている。  
平坦であることは、入り組んだネストより優れている。  
疎であることは、密であることより優れている。  
可読性は重要である。  
特別な例は、規則を逸脱するほど特別ではない。  
しかし実用性は純粋さに勝ってしまう。  
エラーは静寂のうちに過ぎ去ってはならない。  
ただし静寂であることを明示しない限り。  
曖昧であるとき、それをむやみに推測しない。 
あることをする時、一つの(さらに言えば唯一の)自明なやり方があるべきである。  
*Dutch*(オランダ人)でない限り、最初はその方法は自明ではないかもしれない。  
今することは、決してやらないより良い。  
もっとも、決してやらないのは**今すぐに**やるより大概優れている。  
もしその実装の説明が難しいのならば、それは悪い発想である。  
もしその実装の説明が簡単なのならば、それは良い発想かもしれない。  
名前空間はとても素晴らしいアイデアである。積極的にやろう！  


## `this.py`の中身
```python
$ python3 -c 'import this; import sys; print(this.__file__, file=sys.stderr)' 2>&1 1>/dev/null | xargs -J% cat %
s = """Gur Mra bs Clguba, ol Gvz Crgref

Ornhgvshy vf orggre guna htyl.
Rkcyvpvg vf orggre guna vzcyvpvg.
Fvzcyr vf orggre guna pbzcyrk.
Pbzcyrk vf orggre guna pbzcyvpngrq.
Syng vf orggre guna arfgrq.
Fcnefr vf orggre guna qrafr.
Ernqnovyvgl pbhagf.
Fcrpvny pnfrf nera'g fcrpvny rabhtu gb oernx gur ehyrf.
Nygubhtu cenpgvpnyvgl orngf chevgl.
Reebef fubhyq arire cnff fvyragyl.
Hayrff rkcyvpvgyl fvyraprq.
Va gur snpr bs nzovthvgl, ershfr gur grzcgngvba gb thrff.
Gurer fubhyq or bar-- naq cersrenoyl bayl bar --boivbhf jnl gb qb vg.
Nygubhtu gung jnl znl abg or boivbhf ng svefg hayrff lbh'er Qhgpu.
Abj vf orggre guna arire.
Nygubhtu arire vf bsgra orggre guna *evtug* abj.
Vs gur vzcyrzragngvba vf uneq gb rkcynva, vg'f n onq vqrn.
Vs gur vzcyrzragngvba vf rnfl gb rkcynva, vg znl or n tbbq vqrn.
Anzrfcnprf ner bar ubaxvat terng vqrn -- yrg'f qb zber bs gubfr!"""

d = {}
for c in (65, 97):
    for i in range(26):
        d[chr(i+c)] = chr((i+13) % 26 + c)

print("".join([d.get(c, c) for c in s]))

```




