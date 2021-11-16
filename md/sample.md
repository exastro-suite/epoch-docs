---
layout: default
lang: ja
type: learn
title: Sample
version: 0.1.0
description: ページの説明文・要約。SNSリンクなどで表示される文章。
author: Exastro developer
date: 2021/11/09
lastmod: 2021/11/09
---

## 見出し h2
### 見出し h3
#### 見出し h4
##### 見出し h5
###### 見出し h6

```
## 見出し h2
### 見出し h3
#### 見出し h4
##### 見出し h5
###### 見出し h6
```

- \# h1は使用しない。
- 見出しの順番に気を付ける。※h2 のあとに h4 のような順番が飛ぶような使い方はしない。

## 入力例
### リンク、画像
#### リンク
##### 表示サンプル

[Exastro](https://exastro-suite.github.io/docs/index.html)

##### 入力例

```
[Exastro](https://exastro-suite.github.io/docs/index.html)
```

#### 画像
##### 表示サンプル

![Exastro](https://exastro-suite.github.io/docs/asset/logo/exastro/Exastro-logo1-rgb.png){:width="1280" height="300"}

##### 入力例

```
![Exastro](https://exastro-suite.github.io/docs/asset/logo/exastro/Exastro-logo1-rgb.png){:width="1280" height="300"}
```

`{:width="1280" height="300"}`部分の幅と高さは実際の画像サイズを入れてください。
画像遅延読み込み（lazyload）とアンカーリンクのずれをなくすため、画像読み込み前に画像の高さを取得するために使用します。
_入れ忘れると画像が表示されません。_

### 強調、打消し
#### 強調
##### 表示サンプル

| em | _AAAAA_ | *AAAAA* |
| strong | __AAAAA__ | **AAAAA** |
| em + strong | ___AAAAA___ | ***AAAAA*** |

##### 入力例

```
| em | _AAAAA_ | *AAAAA* |
| strong | __AAAAA__ | **AAAAA** |
| em + strong | ___AAAAA___ | ***AAAAA*** |
```

### リスト
#### 順序無しリスト
##### 表示サンプル

- AAAAA1
- AAAAA2
  - BBBBB1
  - BBBBB2
    - CCCCC1
  - DDDDD1

##### 入力例

```
- AAAAA1
- AAAAA2
  - BBBBB1
  - BBBBB2
    - CCCCC1
  - DDDDD1
```

#### 順序付きリスト
##### 表示サンプル

1. AAAAA
2. BBBBB
3. CCCCC

##### 入力例

```
1. AAAAA
2. BBBBB
3. CCCCC
```

#### 定義リスト
##### 表示サンプル

AAA
: BBB
: CCC
: DDD

##### 入力例

```
AAA
: BBB
: CCC
: DDD
```

### 段落
#### 補足説明など
##### 表示サンプル

あああああ
{: .info}

あああああ
{: .check}

あああああ
{: .warning}

あああああ
{: .alert}

##### 入力例

```
あああああ
{: .info}
```

```
あああああ
{: .check}
```

```
あああああ
{: .warning}
```

```
あああああ
{: .alert}
```


### コード
#### インライン
##### 表示サンプル

文章の中に`code`を入れる。

##### 入力例

```
文章の中に`code`を入れる。
```

#### ブロック
##### 表示サンプル

```
cd c:\
```

##### 入力例

````
```
cd c:\
```
````

#### ハイライト（ハイライター：Rouge）

ハイライターはrouge。[対応言語はこちらを参照](https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers)。

##### 表示サンプル

```sh
echo "TEST"
```

##### 入力例

````
```sh
echo "TEST"
```
````

### コードに行数やマーカーをつける

行数やマーカーは*javascriptで追加*しています。

#### 行数

コードの後に`{: .line}`を追加する。

##### 表示サンプル

```html
<div>
    <p>
        行数表示
    </p>
</div>
```
{: .line}

##### 入力例

````
```html
<div>
    <p>
        行数表示
    </p>
</div>
```
{: .line}
````

#### 行数（開始番号指定）

指定の番号から開始する場合は、`{: .line .line100}`のように`.n100`（数字は開始番号）を追加する。

##### 表示サンプル

```html
<div>
    <p>
        行数表示
    </p>
</div>
```
{: .line .n100}

##### 入力例

````
```html
<div>
    <p>
        行数表示
    </p>
</div>
```
{: .line .n100}
````

#### $マーク

$マーク。コードの後に`{: .line .d}`を追加する。

##### 表示サンプル

```sh
sh xxxxx.sh
```
{: .line .d}

##### 入力例

````
```sh
sh xxxxx.sh
```
{: .line .d}
````

#### #マーク

\#マーク。コードの後に`{: .line .s}`を追加する。

##### 表示サンプル

```sh
sh xxxxx.sh
```
{: .line .s}

##### 入力例

````
```sh
sh xxxxx.sh
```
{: .line .s}
````

#### >マーク

\>マーク。コードの後に`{: .line .g}`を追加する。

##### 表示サンプル

```sh
sh xxxxx.sh
```
{: .line .g}

##### 入力例

````
```sh
sh xxxxx.sh
```
{: .line .g}
````
