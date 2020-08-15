# :tickets: Terraform AWS Create Service

AWS Service Create By Terraform

## Getting Started

### Prerequisites

Mac PC

```bash
brew install terraform
```

### Set Up

```bash
vi secret.tfvars
-----------
aws_access_key = "XXXXX"
aws_secret_key = "XXXXX"
-----------
```

### Installing

```bash
$ terraform init
$ terraform plan -var-file="secret.tfvars"
$ terraform apply -var-file="secret.tfvars"
```

### Module

- Terraform

### Reference

https://dev.classmethod.jp/articles/terraform-v0-6-15-supports-cloudfront/

