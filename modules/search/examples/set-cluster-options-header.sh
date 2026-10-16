curl -s -XPUT -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} \
    http://${CB_HOSTNAME}:8094/api/managerOptions \
    -d '<REQUEST_BODY>'