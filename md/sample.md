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

## インライン要素

### リンク

[Exastro](https://exastro-suite.github.io/docs/index.html)

```
[Exastro](https://exastro-suite.github.io/docs/index.html)
```

### 画像

![Exastro](https://exastro-suite.github.io/docs/asset/logo/exastro/Exastro-logo1-rgb.png){:width="1280" height="300"}

```
![Exastro](https://exastro-suite.github.io/docs/asset/logo/exastro/Exastro-logo1-rgb.png){:width="1280" height="300"}
```

`{:width="1280" height="300"}`部分の幅と高さは実際の画像サイズを入れてください。
画像遅延読み込み（lazyload）とアンカーリンクのずれをなくすため、画像読み込み前に画像の高さを取得するために使用します。
_入れ忘れると画像が表示されません。_

### 強調

| em | _AAAAA_ | *AAAAA* |
| strong | __AAAAA__ | **AAAAA** |
| em + strong | ___AAAAA___ | ***AAAAA*** |

```
| em | _AAAAA_ | *AAAAA* |
| strong | __AAAAA__ | **AAAAA** |
| em + strong | ___AAAAA___ | ***AAAAA*** |
```

## リスト

### 順序無しリスト

- AAAAA1
- AAAAA2
  - BBBBB1
  - BBBBB2
    - CCCCC1
  - DDDDD1

```
- AAAAA1
- AAAAA2
  - BBBBB1
  - BBBBB2
    - CCCCC1
  - DDDDD1
```

### 順序付きリスト

1. AAAAA1
2. AAAAA2
  1. BBBBB1
  2. BBBBB2
    1. CCCCC1
  3. DDDDD1

```
1. AAAAA1
2. AAAAA2
  1. BBBBB1
  2. BBBBB2
    1. CCCCC1
  3. DDDDD1
```

### 定義リスト

AAA
: BBB
: CCC
: DDD

```
AAA
: BBB
: CCC
: DDD
```

## 段落（補足説明）

あああああ
{: .info}

```
あああああ
{: .info}
```

あああああ
{: .check}

```
あああああ
{: .check}
```

あああああ
{: .warning}

```
あああああ
{: .warning}
```

あああああ
{: .alert}

```
あああああ
{: .alert}
```

## コード

コードの書き方。

```
cd c:\
```

````
```
cd c:\
```
````

### ハイライト

``` sh
sh xxxxx.sh
```

````
``` sh
sh xxxxx.sh
```
````

ハイライターはrouge。[対応言語](https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers)。

### 行数やマーカー

行数やマーカーは_javascriptで追加_しています。

#### 行数

コードの後に`{: .line}`を追加する。

```html
<div>
    <p>
        行数表示
    </p>
</div>
```
{: .line}

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

指定の番号から開始する場合は、`{: .line .line100}`のように`.line100`（数字は開始番号）を追加する。

```html
<div>
    <p>
        行数表示
    </p>
</div>
```
{: .line .line100}

````
```html
<div>
    <p>
        行数表示
    </p>
</div>
```
{: .line .line100}
````

#### マーカー

$マーク。コードの後に`{: .line .d}`を追加する。

```sh
sh xxxxx.sh
```
{: .line .d}

````
```sh
sh xxxxx.sh
```
{: .line .d}
````

\#マーク。コードの後に`{: .line .s}`を追加する。

```sh
sh xxxxx.sh
```
{: .line .s}

````
```sh
sh xxxxx.sh
```
{: .line .s}
````

\>マーク。コードの後に`{: .line .g}`を追加する。

```sh
sh xxxxx.sh
```
{: .line .g}

````
```sh
sh xxxxx.sh
```
{: .line .g}
````
