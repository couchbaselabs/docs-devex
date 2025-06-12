curl -s -XPUT -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://localhost:8094/api/bucket/travel-sample/scope/inventory/index/travel-sample-alias
  -d \
  '{
    "name": "travel-sample-alias",
    "type": "fulltext-alias",
    "params": {
      "targets": {
        "travel-sample.inventory.landmark-content": {},
        "travel-sample.inventory.hotel-reviews": {},
        "travel-sample.inventory.routes": {}
      }
    },
    "sourceType": "nil",
    "sourceName": "",
    "sourceUUID": "",
    "sourceParams": null,
    "planParams": {},
    "uuid": ""
  }'