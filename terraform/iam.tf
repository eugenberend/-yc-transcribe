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
