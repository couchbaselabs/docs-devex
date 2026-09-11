curl -XPOST -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/travel-sample/scope/inventory/index/travel-sample-nested-index/query \
  -d '{
  "explain": true,
  "fields": [
    "*"
  ],
  "highlight": {},
  "query": {
    "conjuncts": [
      {
        "field": "reviews.content",
        "match": "location"
      },
      {
        "field": "reviews.content",
        "match_phrase": "nice view"
      },
      {
        "min": 4,
        "max": 5,
        "inclusive_min": true,
        "inclusive_max": true,
        "field": "reviews.ratings.Overall"
      }
    ]
  },
  "size": 10,
  "from": 0
}'
