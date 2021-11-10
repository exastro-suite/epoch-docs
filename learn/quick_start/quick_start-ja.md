---
layout: default
lang: ja
type: learn
title: Quick Start
version: 0.1.0
description: EPOCHのインタフェースをスムーズに体感頂くために、クイックスタートをご用意しました。EPOCHでは、Kubernetesを主としたいくつかのソフトウェアと連携し、コンテナベースのCI/CD環境を提供しています。クイックスタートでは、EPOCHのインストールならびにサンプルアプリケーションを使ってCI/CDの流れを体験頂けます。
author: Exastro developer
date: 2021/11/09
lastmod: 2021/11/09
---

## はじめに
### QuickStartについて
#### はじめに

本書は、Exastro EPOCH(以降、EPOCHと表記する)の導入方法ならびに簡単な使い方をチュートリアルを用いて説明します。

#### QuickStartの全体図

![QuickStart全体図](img/overview_quickstart.png){:width="1959" height="633"}

（※1）本クイックスタートでは手順を簡素化するため1つのKubernetesクラスタ上で構成します。

### QuickStartを実施するPC環境ついて

QuickStartの手順を実施するにあたってのPCのソフトウェアは以下の通りです。

![QuickStart手順](img/process_quickstart.png){:width="1864" height="855"}

## インストール

EPOCHをインストールして、CI/CDの環境を準備をしましょう。

### EPOCHのインストール
#### EPOCH全体図

EPOCHをインストールおよびワークスペースを作成した後の構成は、以下の図のようになります。

![EPOCH全体図](img/overall_view_epoch.png){:width="1671" height="694"}

##### 前提条件
###### 環境

- Kubernetes環境が構築されていること
- 使用するServiceAccountにcluster-adminロールが付与されていること
- Kubernetes環境から外部インターネットに接続できること
- PC環境から外部インターネットに接続できること
- PC環境にGit for Windowsがインストールされていること
- ポート番号(30080, 30081, 30443, 30801 , 30804, 30805, 30901～30907)が使用できること
(ポート番号はepoch-install.yamlに記述されており、変更する際は編集後インストールを実行する必要があります）

###### アカウント

- アプリケーションコードを登録するGitHubのアカウントが準備されていること
- Kubernetes Manifestを登録するGitHubのアカウントが準備されていること
- コンテナイメージを登録するDockerHubのアカウントが準備されていること

#### EPOCHインストール
##### ターミナルでkubectlが実行できる環境にSSHログインし、以下のコマンドを実行してEPOCHをインストールします。

``` sh
kubectl apply -f https://github.com/exastro-suite/epoch/releases/download/v0.1.0/epoch-install.yaml
```
{: .line .d}

以下のコマンドでインストールの進行状況を確認できます。

``` sh
kubectl get pod -n epoch-system
```
{: .line .d}

コマンド結果に表示されているすべてのコンポーネントのSTATUSが “Running” であることを確認します。

###### コマンド結果 イメージ

```
NAME                                        READY   STATUS    RESTARTS   AGE
epoch-cicd-api-*********-*****              1/1     Running   0          **s
epoch-rs-organization-api-*********-*****   1/1     Running   0          **s
epoch-rs-workspace-api- *********-*****     1/1     Running   0          **s
～
```

#### 永続ボリューム設定

パイプライン設定用の永続ボリュームを設定します。

##### 以下のコマンドを実行し、マニフェストをGitHubから取得します。

``` sh
curl -OL https://github.com/exastro-suite/epoch/releases/download/v0.1.0/epoch-pv.yaml
```
{: .line .d}

##### 以下のコマンドを実行し、Workerノードのホスト名を確認します。

``` sh
kubectl get node
```
{: .line .d}

###### コマンド結果 イメージ

```
NAME                      STATUS   ROLES                  AGE   VERSION
epoch-kubernetes-master1  Ready    control-plane,master   **d   v1.**.*
epoch-kubernetes-worker1  Ready    worker                 **d   v1.**.*
```

##### epoch-pv.yamlを修正します。（修正箇所はepoch-pv.yamlの最終行）

「# Please specify the host name of the worker node #」の部分を、先ほど確認したWorkerノードのホスト名に置き換え保存します。

###### 変更前

```
values:
  - # Please specify the host name of the worker node #
```

###### 変更後

```
values:
  - epoch-kubernetes-worker1
```

##### 以下のコマンドでkubernetes環境へ反映します。

``` sh
kubectl apply -f epoch-pv.yaml
```
{: .line .d}

#### ArgoRolloutインストール
##### 以下のコマンドを実行し、ArgoRolloutのインストールします。

``` sh
kubectl create namespace argo-rollouts
```
{: .line .d}

``` sh
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
```
{: .line .d}

以上でEPOCHのインストールは完了しました。
次にチュートリアルを実施するための事前準備を実施しましょう！
{: .check}

### リポジトリ準備
#### 使用するリポジトリについて
##### 本クイックスタートで使用するリポジトリは以下の通りです。

- アプリケーションコード用リポジトリ
- IaC用リポジトリ(Staging環境用)
- IaC用リポジトリ(Production環境用)

###### イメージ図

![リポジトリイメージ](img/repository_image.png){:width="1853" height="412"}

#### リポジトリの準備
##### Gitリポジトリを３つ用意します。

1. ブラウザにて自身のGitHubのアカウントでGitHubにサインインします。
2. アカウントメニューからYour Repositriesを選択します。
3. Newを選択し、図で示した値を入力し、Create repositryを選択します。

![リポジトリ準備手順](img/repository_preparation.png){:width="1689" height="654"}

#### アプリケーションコード用リポジトリをPC環境へ準備
##### アプリケーションコード用リポジトリのclone

アプリケーションコード用リポジトリをPC環境にcloneします。
例としてコマンドプロンプトでは、以下の通りとなります。

```
cd "[clone先のフォルダ]"
git clone https://github.com/[Githubのアカウント名]/epoch-sample-app.git
cd epoch-sample-app
git config user.name "[GitHubのユーザ名]"
git config user.email "[GitHubのemailアドレス]"
```
{: .line .g}

ここでcloneしたローカルリポジトリを使って、チュートリアルを行います。

#### Gitトークンの払い出し

1. ブラウザにて自身のGitHubのアカウントでGitHubにサインインします。
2. アカウントメニューからSettingsを選択します。
3. Account settings画面からDeveloper settingsメニューを選択します。
4. Developer settings画面からPersonal access tokensメニューを選択し、Generate new tokenボタンを選択します。
5. New personal access token画面でNote（任意の名称）、Select scopesを全て選択し、Generate tokenボタンを選択します。
6. 表示されたトークン (ghp_***) を後に使用しますので控えてください。

![Gitトークンの払い出し手順](img/token_payout.png){:width="1912" height="513"}

### Manifestテンプレートファイルの準備
#### Manifestテンプレートファイルのダウンロード

EPOCHにアップロードするManifestテンプレートファイル（２ファイル）をダウンロードします。

##### ブラウザで以下のURLを表示します。

1. [https://raw.githubusercontent.com/exastro-suite/epoch-sample-app/master/manifest-template/api-app.yaml](https://raw.githubusercontent.com/exastro-suite/epoch-sample-app/master/manifest-template/api-app.yaml)
2. [https://raw.githubusercontent.com/exastro-suite/epoch-sample-app/master/manifest-template/ui-app.yaml](https://raw.githubusercontent.com/exastro-suite/epoch-sample-app/master/manifest-template/ui-app.yaml)

##### ブラウザにManifestテンプレートが表示されますので、操作しているPCに保存します。

![テンプレート保存方法](img/save_template.png){:width="1433" height="456"}

以上で事前準備は完了しました。
ワークスペース作成へ進みましょう！
{: .check}

## ワークスペース作成

ワークスペースを作成し、CI/CDの準備をしましょう。

### ワークスペース
#### ワークスペース

EPOCHでは、１つの開発環境をワークスペースという単位で管理します。
ワークスペース作成は、画面から入力された情報をもとに、各アプリケーションへ必要な情報を登録し、CI/CDの準備を行ないます。

![ワークスペースイメージ](img/workspace_image.png){:width="1702" height="717"}

### CI/CDについて
#### CI/CDとは

アプリケーションの開発～リリースまでの一連の作業を自動化し、アプリケーション提供の頻度を高める手法です。

##### CI（継続的インテグレーション）

アプリケーションコードの変更を起点に、ビルドやテストの実行といった開発者の作業を自動化する手法を指します。

##### CD（継続的デリバリー）

実行環境へのリリースまでを自動化する手法を指します。

##### CI/CDのイメージ

![CI/CDイメージ](img/ci_cd_image.png){:width="1480" height="404"}

### EPOCHのCI/CD
#### EPOCHのCI/CD

EPOCHのCI/CDの流れを、下図に示します。

![EPOCH CI/CDイメージ](img/epoch_ci_cd_image.png){:width="1940" height="735"}

### EPOCH起動
#### ブラウザより以下のURLで接続します。

```
https://[インストール先のIPアドレスまたはホスト名]:30443/workspace.html
```

![EPOCH画面](img/epoch_start_up.png){:width="1446" height="720"}

続いて必要な情報を入力してワークスペースを作成してみましょう！
{: .check}

### ワークスペース作成
#### ワークスペース基本情報

ワークスペース名を入力します。

![ワークスペース名入力画面](img/input_workspace_name.png){:width="1710" height="488"}

| 項目 | 入力・選択内容 | 説明 |
| --- | --- | --- |
| ワークスペース名 | EPOCHクイックスタート | 作成するワークスペース名 |
| 備考 | なし | 作成するワークスペースの説明や備考 |

#### アプリケーションコードリポジトリ

アプリケーションコードリポジトリの情報を入力します。

![アプリケーションコードリポジトリ情報入力画面](img/input_app_code_repository.png){:width="1075" height="517"}

| 項目 | 入力・選択内容 | 説明 |
| --- | --- | --- |
| ユーザ名 | (自身のGitHubのアカウント名) | GitHubのアカウント名 |
| トークン | (自身のGitHubのトークン) | GitHubのトークン<br>（事前準備 Gitトークンの払い出しを参照） |
| GitリポジトリURL | https://github.com/_\[GitHubのアカウント名]_/epoch-sample-app.git | 準備で作成したアプリケーションコード用リポジトリのURL |
{: .row-h1}

#### パイプラインTEKTON

TEKTONに設定するパイプライン情報を入力します。

![パイプラインTEKTON情報入力画面](img/input_tekton.png){:width="1183" height="516"}

| 項目 | 入力・選択内容 | 説明 |
| --- | --- | --- |
| ビルドブランチ | main,master | ビルド対象のアプリケーションのGitHubのブランチ |
| ビルドDockerファイルパス | ./api-app/Dockerfile | アプリケーションのDockerfileのパス |

#### レジストリサービス

ビルド後のイメージ登録先（レジストリ）情報を入力します。

![レジストリサービス情報入力画面](img/input_registry_service.png){:width="1265" height="562"}

| 項目 | 入力・選択内容 | 説明 |
| --- | --- | --- |
| ユーザ名 | （自身のDockerHubのアカウント名） | DockerHubのアカウント名 |
| パスワード | （自身のDockerHubのパスワード） | DockerHubのパスワード |
| イメージ出力先 | _\[DockerHubのアカウント名]_/epoch-sample-**api**<br>_※ユーザ名入力後に表示される内容を修正してください。_ | DockerHubのイメージ出力先のパス |

#### パイプラインArgo CD

ArgoCDに設定するDeploy先の情報を入力します。

![ArgoCD情報入力画面](img/input_argo_cd.png){:width="1637" height="512"}

#####  環境1：Staging環境

| 項目 | 入力・選択内容 | 説明 |
| --- | --- | --- |
| 環境名 | staging | デプロイ環境の名前 |
| Namespace | epoch-sample-app-staging | デプロイ先のNamespace |

##### 環境2：Production環境

| 項目 | 入力・選択内容 | 説明 |
| --- | --- | --- |
| 環境名 | production | デプロイ環境の名前 |
| Namespace | epoch-sample-app-production | デプロイ先のNamespace |

#### IaCリポジトリ

マニフェストの登録先となるリポジトリ情報を入力します。

![IaCリポジトリ情報入力画面](img/input_iac_repository.png){:width="1450" height="553"}

| 項目 | 入力・選択内容 | 説明 |
| --- | --- | --- |
| GitリポジトリURL | https://github.com/_\[GitHubのアカウント名]_/_\[各環境のリポジトリ]_.git | 各環境のmanifestリポジトリのURL<br>（事前準備 IaC用リポジトリの準備を参照） |

#### ワークスペース作成

すべての入力が完了しましたら【ワークスペース作成】ボタンを押下します。

![ワークスペース作成画面](img/create_workspace.png){:width="993" height="525"}

これでCI/CDパイプラインが構築されました。
チュートリアルを実践してCI/CDパイプラインを体験してみましょう！
{: .check}