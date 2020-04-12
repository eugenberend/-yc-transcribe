terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "gitlab-runner-tfstate"
    key        = "gitlab/yc-transcribe.tfstate"
    region     = "us-east-1"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
