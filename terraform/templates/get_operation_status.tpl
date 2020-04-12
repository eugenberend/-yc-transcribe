export API_KEY=${api_key}
export uri="https://operation.api.cloud.yandex.net/operations/$job_id"
response=$(curl -X GET -H "Authorization: Api-Key $API_KEY" $uri)
response_status=$(echo $response | jq -r ".done")
while [ $response_status = "false" ]; do
    echo "Waiting for job completion..."
    sleep 5
    response=$(curl -X GET -H "Authorization: Api-Key $API_KEY" $uri)
    response_status=$(echo $response | jq -r ".done")
done
echo $response | jq -r '[.response.chunks[].alternatives[].text]' >> transcript.json
