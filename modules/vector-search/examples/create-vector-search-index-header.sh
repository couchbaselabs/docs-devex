curl -k -XPUT -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} \
    https://${CB_HOSTNAME}:18094/api/bucket/vector-sample/scope/color/index/color-index \
    -d '{ .....  JSON Index Definiton Goes Here ... }'
