curl -s -XPUT -H "Content-Type: application/json" \
-u ${CB_USERNAME}:${CB_PASSWORD} https://${CB_HOSTNAME}:18094/api/bucket/${BUCKET_NAM}E/scope/${SCOPE_NAME}/index/${INDEX_NAME}/query -d \