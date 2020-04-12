resource "yandex_storage_bucket" "s2t" {
  bucket     = "transcribe-bucket"
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

resource "yandex_storage_object" "sample" {
  bucket     = yandex_storage_bucket.s2t.id
  key        = "sample"
  source     = "../input/sample.opus"
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}
