# yc-transcribe

Транскрибирование аудиозаписей Яндекс.Облаком

## Требования

1. Сервисный аккаунт с правами admin на default folder и viewer на cloud
2. Переменные CI/CD:
   1. Cloud ID
   2. Folder ID
   3. IAM key для сервисного аккаунта
   4. IAM static access key (access_key:key_id) для сервисного аккаунта
   5. IAM static secret access key (secret) для сервисного аккаунта
3. Бакет для tfstate. Доступ нужно ограничить сервисным аккаунтом.
