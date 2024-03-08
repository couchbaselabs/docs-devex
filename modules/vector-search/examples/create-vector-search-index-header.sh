curl -k -XPUT -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} \
    https://${CB_FTSHOSTNAME}:18094/api/bucket/${BUCKET_NAME}/scope/${SCOPE_NAME}/index/${INDEX_NAME} \
    -d '{ .....  JSON Index Definiton Goes Here ... }'
