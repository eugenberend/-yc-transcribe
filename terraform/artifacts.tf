resource "local_file" "body" {
  content = templatefile(
    "${path.module}/templates/body.tpl",
    {
      uri = "https://${yandex_storage_bucket.s2t.bucket_domain_name}/${yandex_storage_object.sample.id}"
    }
  )
  filename        = "artifacts/body.json"
  file_permission = "644"
  depends_on = [
      yandex_storage_object.sample
  ]
}

resource "local_file" "send_recognition_request" {
  content = templatefile(
    "${path.module}/templates/send_recognition_request.tpl",
    {
      api_key = yandex_iam_service_account_api_key.sa-api-key.secret_key
    }
  )
  filename        = "artifacts/send_recognition_request.sh"
  file_permission = "755"
  depends_on = [
      yandex_storage_object.sample
  ]
}

resource "local_file" "get_operation_status" {
  content = templatefile(
    "${path.module}/templates/get_operation_status.tpl",
    {
      api_key = yandex_iam_service_account_api_key.sa-api-key.secret_key
    }
  )
  filename        = "artifacts/get_operation_status.sh"
  file_permission = "755"
  depends_on = [
      yandex_storage_object.sample
  ]
}
