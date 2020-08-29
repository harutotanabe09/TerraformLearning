# Variable list
variable "name" { default = "enjapan-service-storage-20200827" }
variable "region" { default = "ap-northeast-1" }
variable "acl" { default = "private" }
variable "index" { default = "index.html" }
variable "tag" { default = "20100010" }
# 公開するサイトのルートドメイン
variable "root_domain" { default = "testdomain2019.com" }
# 公開するサイトのドメイン
variable "site_domain" { default = "foo.sitedomain2019.com" }
