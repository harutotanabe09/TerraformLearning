### Terraformとは？

インフラをコード定義するためのツール

定義したファイルをクラウド（AWS,GCP）といったサービスに対して、ソースコードで定義して実行できる

### きっかけ

案件で、Terraform管理しようかという議題が一瞬あがった為、勉強したときのメモ

### 特徴1：ソース管理が楽

分割を意識する必要なし。階層のtfファイルがすべて実行される

Terraformは拡張子が*.tfのファイルを自動的にテンプレートとして認識してくれるので、
テンプレートファイルを複数に分割することも可能

### 特徴2：いろんなクラウドサービスに展開

AWSだけではなく、GCPやAzureも使える

### 特徴3：コマンドで整形できる

プログラム書くと、インデントが揃わなかったりイラつくことを解消できるコマンドがある

### 特徴4：公式ドキュメント読みやすい

https://www.terraform.io/docs/providers/aws/index.html

### Terraformのインストール手順

Brewが入っているなら以下コマンドで一発

```sh
brew install terraform
```

### 初期化

```sh
terraform init
```

### 初期化（バージョンアップ）
```sh
terraform init -upgrade
```

### 整形
```sh
terraform fmt
```

### ドライ・ラン

```sh
terraform plan -var-file="secret.tfvars"
```

### 適用
```sh
terraform apply -var-file="secret.tfvars"
```

### 削除確認

```sh
terraform plan -destroy
```

### リソース一括削除
```sh
terraform destroy  -var-file="secret.tfvars"
```

### 環境ごと設定
```sh
terraform workspace new develop
terraform workspace list
```

### ドキュメント
https://qiita.com/minamijoyo/items/1f57c62bed781ab8f4d7
