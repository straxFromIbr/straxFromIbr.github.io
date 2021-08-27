---
title: "[Python] クラスの多重継承"
date: 2021-08-27T22:19:47+09:00
categories:
- プログラミング
- Python
tags:
- プログラミング
- Python
keywords:
- tech
# thumbnailImage: /images/python-multi-inher/
#thumbnailImage: //example.com/image.jpg
summary: "Pythonでクラスの多重継承をしたさいの挙動"
---
# サンプルコード
次のようにFooClassとBarClassの2つを継承するクラスを考える。

```python
class FooClass:
    def __init__(self):
        self.common_var = "foo"
        self.foo_var = "foo"

    def common_method(self):
        print("Foo!")

    def foo_method(self):
        print("Foo!")


class BarClass:
    def __init__(self):
        self.common_var = "bar"
        self.bar_var = "bar"

    def common_method(self):
        print("Bar!")

    def bar_method(self):
        print("Bar!")


class FooBarClass(FooClass, BarClass):
    def __init__(self):
        print(super())
        super().__init__()

    def super_bar_method(self):
        print("#>>> super bar")
        super().bar_method()
        print("#<<< super bar")


class BarFooClass(BarClass, FooClass):
    def __init__(self):
        super().__init__()

    def super_foo_method(self):
        print("#>>> super foo")
        super().foo_method()
        print("#<<< super foo")
```

# 複数の親で共通する名前を持つメソッドの名前解決

次のように`FooBarClass`と`BarFooClass`のインスタンス`fb`,`bf`を作成し、それぞれのインスタンスから`common_method()`を呼び出す。
`fb.common_method()`は`Foo!`を出力し、`bf.common_method()`は`Bar!`を出力することから継承順にメソッドを検索していることがわかる。

具体的には`.__mro__`属性、または`.mro()`メソッドで名前が検索される順番を取得できる。
```
>>> FooBarClass.__mro__
(<class '__main__.FooBarClass'>, <class '__main__.FooClass'>, <class '__main__.BarClass'>, <class 'object'>)

>>> BarFooClass.__mro__
(<class '__main__.BarFooClass'>, <class '__main__.BarClass'>, <class '__main__.FooClass'>, <class 'object'>)
```
# 親メソッドの呼び出し
`FooBarClass`の`super_bar_method()`内部では組み込み関数`super()`により親クラスを取得しそのメソッド`bar_method()`を実行している。
```
>>> fb.super_bar_method()
#>>> super bar
Bar!
#<<< super bar
```
一方コンストラクタ内で親クラスのコンストラクタを呼び出しているが、`fb.bar_var`とすると`AttributeError`を送出する。これは上述の`mro`の順番で一番最初にみつかったメソッドを実行するからだ。

# 直接の親クラス
次のように`__base__`属性で基底クラスを取得すると、前述の`super()`関数と異なり一つ目の親クラスのみしか取得できないことがわかる。
```
>>> FooBarClass.__base__.foo_method(None)
Foo!
>>> FooBarClass.__base__.bar_method(None)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: type object 'FooClass' has no attribute 'bar_method'
```
基底となる全てのクラスを取得したい場合は`.__bases__`属性を参照する。
例：
```
>>> FooBarClass.__base__
<class '__main__.FooClass'>
>>> BarFooClass.__base__
<class '__main__.BarClass'>

>>> FooBarClass.__bases__
(<class '__main__.FooClass'>, <class '__main__.BarClass'>)
>>> BarFooClass.__bases__
(<class '__main__.BarClass'>, <class '__main__.FooClass'>)
```


