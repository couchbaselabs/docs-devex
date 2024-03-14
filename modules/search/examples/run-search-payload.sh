curl -XPOST -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/travel-sample/scope/inventory/index/landmark-content-index/query \
  -d '{
    "explain": true,
    "fields": [
      "*"
    ],
    "highlight": {},
    "query": {
      "query": "+view +food +beach"
    },
    "size": 10,
    "from": 0
  }'
