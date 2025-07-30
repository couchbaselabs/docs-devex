curl -XPOST -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/e-commerce/scope/products/index/products-index/query \
-d '{
      "fields": ["description", "price", "product_name"],
      "query": {
        "conjuncts": [
          {
            "term": "Electronics",
            "field": "category"
          },
          {
            "field": "price",
            "min": 100.00,
            "max": 300.00,
            "inclusive_max": true
          }
        ]
      },
      "knn": [
        {
          "k": 5,
          "field": "embedding",
          "vector": [0.23, -0.75, 0.61, ...]
        }
      ],
      "ctl": {
        "global_scoring": true
      }
    }'