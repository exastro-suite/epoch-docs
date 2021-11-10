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
- 見出しの順番は気を付ける。
※h2 のあとに h4 のような順番が飛ぶような使い方はしない。

## 段落（補足説明）

info
{: .info}

```
info
{: .info}
```

check
{: .check}

```
check
{: .check}
```

warning
{: .warning}

```
warning
{: .warning}
```

alert
{: .alert}

```
alert
{: .alert}
```

:::note info
TEST
:::

## コード

```
cd c:\
```

$マークを付ける。

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

```sh
curl -OL https://github.com/exastro-suite/epoch/releases/download/v0.1.0/epoch-pv.yaml
```
{: .line .s}

```sh
curl -OL https://github.com/exastro-suite/epoch/releases/download/v0.1.0/epoch-pv.yaml
```
{: .line .g}
