curl -XPOST -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/travel-sample/scope/inventory/index/landmark-content-index/query \
  -d '{
    "explain": true,
    "fields": [
      "content"
    ],
    "highlight": {},
    "query": {
        "location": {
            "lon": -2.235143,
            "lat": 53.482358
        },
            "distance": "100mi",
            "field": "geo"
    },
    "size": 10,
    "from": 0
  }'