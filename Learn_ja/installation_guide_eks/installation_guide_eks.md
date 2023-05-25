---
layout: document
lang: ja
type: learn
title: Amazon EKSへのインストール
version: 1.2.0
author: Exastro Developer
date: 2022/02/24
lastmod: 2023/05/24
---

## はじめに
本書では**Exastro EPOCH**(以下EPOCH)を**Amazon Elastic Kubernetes Service**(以下EKS)上へインストールする手順を扱います。これには以下の内容が含まれます。

- [必要なコマンドラインツールの導入](#事前準備)
- [`eksctl`を用いたEKSクラスターの構築・設定手順](#eksクラスタの構築設定)
- [EPOCHの利用に必要なセキュリティグループの設定](#セキュリティグループの設定)
- [IAMユーザの権限設定](#本書の作業を実行するために必要な最低限の権限)

### 構成イメージ
![epoch_on_eks_image](img/epochOnEKS.png){:width="762" height="509"}


## Amazon EKSへのインストール
### 事前準備
[EKSクラスタの作成手順](#eksクラスタの構築設定)を実行する前に、AmazonEKSクラスターの作成と管理に必要な下記のリソースをインストールおよび設定しておく必要があります。

- [kubectl](#kubectlのインストール)
- [AWS-CLI version2](#aws-cli-version2のインストール設定)
- [eksctl](#eksctlのインストール)



#### `kubectl`のインストール
Kubernetesクラスターを操作するためのコマンドラインツールです。
EPOCHのインストールやその後の管理作業に利用されます。

下記はLinux環境に`kubectl v1.24`をインストールする場合のコマンドです。
それ以外の場合においては、[こちら](https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/install-kubectl.html)を参考に、`kubectl`をインストールしてください。

作成する予定のKubernetesクラスタと、ここでインストールする`kubectl`はマイナーバージョンの差が1以内である必要があります。
例えばKubernetesクラスタにv1.24を採用する場合、`kubectl`は1.23,1.24,1,25のいずれかである必要があります。
※2023年5月現在、EPOCHが動作確認が取れているKubernetesクラスターバージョンは1.21 ～ 1.24です。
{: .info}

**コマンド(Linuxに`kubectl v1.24`をインストールする場合)**
```bash
# バイナリファイルのダウンロード
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.11/2023-03-17/bin/linux/amd64/kubectl

# バイナリへの実行アクセス許可
chmod +x ./kubectl

# バイナリを PATH のフォルダにコピーする
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
```
{: .line .d}

#### `AWS CLI version2`のインストール・設定
AWSサービスを管理するためのコマンドラインツールです。


##### インストールコマンド
下記はLinux環境に最新の`AWS CLI version2`をインストールする場合のコマンドです。
それ以外の環境においては、[こちら](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2.html)を参考に、手持ちの環境に`AWS CLI version2`をインストールしてください。

**コマンド(Linuxに最新の`AWS CLI version2`をインストールする場合)**
```bash
# インストールファイルのダウンロード
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# インストールファイルの解凍
unzip awscliv2.zip

# インストールの実行
sudo ./aws/install

# インストールの確認
aws --version
```
{: .line .d}

##### 設定コマンド
IAMユーザのアクセスキーをAWS CLIに設定します。
これらの認証情報は後述する`eksctl`コマンドの実行時にも利用されます。

設定するIAMユーザは**EKSやその他のサービスへのアクセス権限を持っている必要があります。**
必要なIAMポリシーの設定については別途[付録 本書の作業を実行するために必要な最低限の権限](#本書の作業を実行するために必要な最低限の権限)を参照して設定してください。
{: .info}

**コマンド**
```bash
aws configure
# AWS Access Key ID [None]: <IAMユーザのアクセスキーID>
# AWS Secret Access Key [None]: <IAMユーザのシークレットアクセスキー>
# Default region name [None]: ap-northeast-1
# Default output format [None]: json
```
{: .line .d}

#### `eksctl`のインストール
AWS CLIと共通の認証情報を利用し、EKSに対してクラスタの作成を含む様々な操作を実行するためのコマンドラインツールです。

##### インストールコマンド
下記はLinux(amd64)環境に最新の`eksctl`をインストールする場合のコマンドです。
それ以外の環境においては、[こちら](https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/eksctl.html)を参考に、手持ちの環境に`eksctl`をインストールしてください。

**コマンド**
```bash
# eksctlの最新リリースをダウンロードして展開します
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# 展開したバイナリファイルを/usr/local/binへ移動する
sudo mv /tmp/eksctl /usr/local/bin

# インストールの確認
eksctl version
```

以上の手順で、必要なコマンドラインツールの準備が全て完了しました。
{: .check}

### EKSクラスタの構築・設定
#### `eksctl create cluster` の実行
[事前準備](#事前準備)を終えたあと、EKSクラスターの作成を行います。
下記の`eksctl create cluster`コマンドを実行することで、CloudFormationスタックが作成されます(作成には数分～数十分の時間が掛かります)。

CloudFormationスタックにはVPC、EC2、IAM等の関連サービスのリソースが定義されており、自動でそれらのリソースが作成されます。


**コマンド**
```bash
# EKSクラスターの作成
eksctl create cluster \
--name my-epoch-cluster \
--nodegroup-name my-epoch \
--region ap-northeast-1 \
--zones ap-northeast-1a,ap-northeast-1c,ap-northeast-1d \
--node-type c5.4xlarge \
--node-volume-size 32 \
--managed \
--nodes 1 \
--version 1.24
```

EKSクラスタのリソース名等を変更する場合、下記オプションの解説を参照して該当箇所を適宜変更してください。
{: .info}

**オプションの解説**

下記は`eksctl create cluster`コマンドのオプションの概要です。


|オプション名|解説|
|:--|:--|
|name|EKSクラスタのリソース名です。|
|nodegroup-name|EKSクラスタノード(= EC2インスタンス)グループのリソース名です。|
|region|リソースが作成されるAWSリージョン名です。|
|zones|1つ以上のアベイラビリティゾーンを指定します。<br>EKSクラスターノードやサブネットが指定したゾーンに分散して作成されます。|
|node-type|EKSクラスターノードのインスタンスファミリーです。<br>例：c5.xlarge|
|node-volume-size|EKSクラスターノードにアタッチされるボリュームの容量(GB)です。|
|managed|EKSクラスターノードがEC2 AutoScalingグループの一部として作成されます。|
|nodes|作成されるEKSクラスターノードの台数です。|


#### EKSクラスターを確認する
`eksctl create cluster`コマンドの実行が完了した後、下記のコマンドでEKSクラスターノードが作成されていることを確認して下さい。

**コマンド**
```bash
# Kubernetesクラスターノードを表示する
kubectl get nodes
```
{: .line .d}

**出力例**

```bash
NAME                                                STATUS   ROLES    AGE   VERSION
ip-xxx-xxx-xxx-xxx.ap-northeast-1.compute.internal   Ready    <none>   15m   v1.24.11-eks-xxxxxxx
ip-xxx-xxx-xxx-xxx.ap-northeast-1.compute.internal   Ready    <none>   15m   v1.24.11-eks-xxxxxxx
```

以上の手順でEKSクラスタの作成が完了しました。
{: .check}

### セキュリティグループの設定
[EKSクラスタの作成手順](#eksクラスタの構築設定)の手順を実行したことで、EKSクラスターを含む関連リソースが作成されています。

本項ではセキュリティグループの許可設定を編集して、EPOCHを利用できるように設定します。


{: .info}

#### 環境変数の設定
セキュリティグループの設定はAWS CLIを利用して行います。
まずは、作成したEKSクラスタの関連情報を環境変数に登録します。

***

##### セキュリティグループID
EKSクラスタを構成するEC2インスタンスには、__自動で作成されたセキュリティグループが割り当てられています。__ 以降の手順ではこのセキュリティグループに対して設定を行います。<br> 
下記のコマンドを実行して`セキュリティグループID`を確認します。

**コマンド**
```bash
# セキュリティグループIDの確認
EKS_SECURITY_GROUP_ID=`aws eks describe-cluster --name <作成したEKSクラスタのリソース名> --query cluster.resourcesVpcConfig.clusterSecurityGroupId | sed 's/"//g'`

# 値を表示する
echo $EKS_SECURITY_GROUP_ID
```
{: .line .d}

**出力例(セキュリティグループID)**
```bash
sg-123z1234567890123
```

***

##### EKSクラスターノードのパブリックIPアドレス
下記のコマンドを実行して`EKSクラスターノードのパブリックIPアドレス`を確認します。

EPOCHのユーザ認証機能が正常に動作するためには、
**EKSクラスターノードが互いにパブリックIPアドレスで疎通できる必要があります。**
{: .info}

**コマンド**
```bash
# パブリックIPアドレスの確認
EKS_NODE_EXTERNAL_IP_LIST=`kubectl get nodes -o=jsonpath='{range .items[*].status.addresses[?(@.type=="ExternalIP")]}{.address}{" "}{end}'`

# 値を表示する
echo $EKS_NODE_EXTERNAL_IP_LIST
```
{: .line .d}

**出力例(パブリックIPアドレス)**
```bash
9.87.65.*** 123.45.67.**
```

#### EPOCHが利用しているNodePortへのアクセス許可

##### EPOCHユーザの端末からのアクセスを許可する
EPOCHユーザがブラウザからEPOCHや関連ソフトウェアのUIにアクセスするために、
ユーザの端末から下記のポートへのアクセスを許可する必要があります。

- `30000-32767/tcp`

下記のコマンドを実行して、EPOCHが利用しているNodePortへのアクセスを許可します。

**コマンド**

```bash
# 環境変数の定義
SOURCE_CIDR=<アクセスを許可するCIDR範囲 (例)10.23.45.XX/32>

# セキュリティグループの設定
aws ec2 authorize-security-group-ingress --group-id ${EKS_SECURITY_GROUP_ID} --protocol tcp --port 30000-32767 --cidr ${SOURCE_CIDR}
```
{: .line .d}

複数のCIDR範囲からのアクセスを設定する必要がある場合、環境変数`SOURCE_CIDR`の値を更新して再度コマンドを実行します。
{: .info}
***

##### EKSクラスターノードによる相互通信を許可する
EKSクラスターノードが互いにパブリックIPアドレスを利用して疎通できるように設定します。

```bash
# セキュリティグループの設定
for EXTERNAL_IP in ${EKS_NODE_EXTERNAL_IP_LIST}
do
aws ec2 authorize-security-group-ingress --group-id ${EKS_SECURITY_GROUP_ID} --protocol tcp --port 0-65535 --cidr ${EXTERNAL_IP}/32
done
```
{: .line .d}

***

##### Github WebhookからEPOCHへのアクセスを許可する
Github WebhookからEPOCHへのアクセスを許可します。

GithubのIPアドレスについて、詳細は[Github Docs](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/about-githubs-ip-addresses)を参照してください。

```bash
# セキュリティグループの設定
for WEBHOOK_SOURCE_IP in 143.55.64.0/20 140.82.112.0/20 192.30.252.0/22 185.199.108.0/22
do
aws ec2 authorize-security-group-ingress --group-id ${EKS_SECURITY_GROUP_ID} --protocol tcp --port 30443 --cidr ${WEBHOOK_SOURCE_IP}
done
```

以上の手順でEKSクラスタ用のセキュリティグループ設定が完了しました。
{: .check}

### EPOCHのインストール
以上の手順で、EPOCHの利用に必要なEKSの設定が完了しました。

 [Learn資料「EPOCH Install」](https://exastro-suite.github.io/epoch-docs/Learn_ja/installation_guide/installation_guide_ja.html)を参照して、EPOCHのインストールを実行してください。

以上で本書の手順は終了です。
{: .check}

## 付録 
### 本書の作業を実行するために必要な最低限の権限
#### IAMポリシーの設定
下記4点は、本書の手順を実施するために必要な最低限のIAMポリシーです。

- [AmazonEC2FullAccess](#amazonec2fullaccess-awsマネージドポリシー)
- [AWSCloudFormationFullAccess](#awscloudformationfullaccess-awsマネージドポリシー)
- [EKSFullAccess](#eksfullaccess)
- [IAMLimitedAccess](#iamlimitedaccess)


**これら全てのポリシー、もしくはこれら以上の権限を設定したポリシー**が、利用するIAMユーザに割り当てられている必要があります。

##### AmazonEC2FullAccess (AWSマネージドポリシー)
EC2へのアクションを全て許可するAWSマネージドポリシーです。
ユーザ、もしくはユーザグループにポリシーをアタッチしてください。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "transitgateway.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
```

##### AWSCloudFormationFullAccess (AWSマネージドポリシー)
CloudFormationへのアクションを全て許可するAWSマネージドポリシーです。
ユーザ、もしくはユーザグループにポリシーをアタッチしてください。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:*"
            ],
            "Resource": "*"
        }
    ]
}
```

##### EKSFullAccess
EKSへのアクションを全て許可するIAMポリシーです。
`<account_id>`をご利用のAWSアカウントのIDで置き換えたうえでポリシーを作成・アタッチしてください。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": "*"
        },
        {
            "Action": [
                "ssm:GetParameter",
                "ssm:GetParameters"
            ],
            "Resource": [
                "arn:aws:ssm:*:<account_id>:parameter/aws/*",
                "arn:aws:ssm:*::parameter/aws/*"
            ],
            "Effect": "Allow"
        },
        {
             "Action": [
               "kms:CreateGrant",
               "kms:DescribeKey"
             ],
             "Resource": "*",
             "Effect": "Allow"
        },
        {
             "Action": [
               "logs:PutRetentionPolicy"
             ],
             "Resource": "*",
             "Effect": "Allow"
        }        
    ]
}
```

##### IAMLimitedAccess
IAMへのアクションを一部許可するIAMポリシーです。
`<account_id>`をご利用のAWSアカウントのIDで置き換えたうえでポリシーを作成・アタッチしてください。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateInstanceProfile",
                "iam:DeleteInstanceProfile",
                "iam:GetInstanceProfile",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:GetRole",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:AttachRolePolicy",
                "iam:PutRolePolicy",
                "iam:ListInstanceProfiles",
                "iam:AddRoleToInstanceProfile",
                "iam:ListInstanceProfilesForRole",
                "iam:PassRole",
                "iam:DetachRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:GetRolePolicy",
                "iam:GetOpenIDConnectProvider",
                "iam:CreateOpenIDConnectProvider",
                "iam:DeleteOpenIDConnectProvider",
                "iam:TagOpenIDConnectProvider",                
                "iam:ListAttachedRolePolicies",
                "iam:TagRole"
            ],
            "Resource": [
                "arn:aws:iam::<account_id>:instance-profile/eksctl-*",
                "arn:aws:iam::<account_id>:role/eksctl-*",
                "arn:aws:iam::<account_id>:oidc-provider/*",
                "arn:aws:iam::<account_id>:role/aws-service-role/eks-nodegroup.amazonaws.com/AWSServiceRoleForAmazonEKSNodegroup",
                "arn:aws:iam::<account_id>:role/eksctl-managed-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetRole"
            ],
            "Resource": [
                "arn:aws:iam::<account_id>:role/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "eks.amazonaws.com",
                        "eks-nodegroup.amazonaws.com",
                        "eks-fargate.amazonaws.com"
                    ]
                }
            }
        }
    ]
}
```
