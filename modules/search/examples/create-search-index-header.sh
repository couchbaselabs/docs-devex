curl -s -XPUT -H "Content-Type: application/json" \
    -u $CB_USERNAME:$CB_PASSWORD https://$CB_HOSTNAME:18094/api/bucket/travel-sample/scope/inventory/index/landmark-content-index 
    -d \