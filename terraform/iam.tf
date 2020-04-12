provider "yandex" {}

resource "yandex_iam_service_account" "sa" {
  name        = "svc-transcribe-bucket-editor"
  description = "service account to manage speech-to-text"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  role      = "editor"

  members = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
}

resource "yandex_iam_service_account_api_key" "sa-api-key" {
  service_account_id = yandex_iam_service_account.sa.id
}

resource "yandex_storage_bucket" "s2t" {
  bucket     = "speech-to-text"
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

resource "yandex_storage_object" "sample" {
  bucket     = yandex_storage_bucket.s2t.id
  key        = "sample"
  source     = "../sample.opus"
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

resource "local_file" "body" {
  content = templatefile(
    "body.tpl",
    {
      uri = "https://${yandex_storage_bucket.s2t.bucket_domain_name}/${yandex_storage_object.sample.id}"
    }
  )
  filename        = "../body.json"
  file_permission = "644"
}

resource "local_file" "send_recognition_request" {
  content = templatefile(
    "send_recognition_request.tpl",
    {
      api_key = yandex_iam_service_account_api_key.sa-api-key.secret_key
    }
  )
  filename        = "../send_recognition_request.sh"
  file_permission = "755"
}

resource "local_file" "get_operation_status" {
  content = templatefile(
    "get_operation_status.tpl",
    {
      api_key = yandex_iam_service_account_api_key.sa-api-key.secret_key
    }
  )
  filename        = "../get_operation_status.sh"
  file_permission = "755"
}
