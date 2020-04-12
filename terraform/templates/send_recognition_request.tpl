export API_KEY=${api_key}
export job_id=$(curl -X POST \
    -H "Authorization: Api-Key $API_KEY" \
    -d '@body.json' \
    https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize |\
    jq -r ".id")
echo "export job_id=$job_id" >> job_id
