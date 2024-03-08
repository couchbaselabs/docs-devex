curl -s -XPUT -H "Content-Type: application/json" \
    -u $CB_USERNAME:$CB_PASSWORD https://$CB_HOSTNAME:18094/api/bucket/$BUCKET-NAME/scope/$SCOPE-NAME/index/$INDEX-NAME/query -d \