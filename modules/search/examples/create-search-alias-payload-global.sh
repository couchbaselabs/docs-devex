curl -s -XPUT -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://localhost:8094/api/index/travel-color-alias
  -d \
  '{
    "name": "travel-sample-alias",
    "type": "fulltext-alias",
    "params": {
      "targets": {
        "travel-sample.inventory.landmark-content": {},
        "vector-sample.color.color-index": {}
      }
    },
    "sourceType": "nil",
    "sourceName": "",
    "sourceUUID": "",
    "sourceParams": null,
    "planParams": {},
    "uuid": ""
  }'