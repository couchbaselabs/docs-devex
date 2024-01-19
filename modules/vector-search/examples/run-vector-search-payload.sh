curl -XPOST -H "Content-Type: application/json" \
  -u $CB_USERNAME:$CB_PASSWORD http://$CB_HOSTNAME:8094/api/bucket/vector-sample/scope/color/index/color-index/query \
-d '{
      "fields": ["*"], 
      "query": { 
        "min": 70, 
        "max": 80,  
        "inclusive_min": false,  
        "inclusive_max": true,  
        "field": "brightness" 
      }, 
      "knn": [
        {
          "k": 10, 
          "field": "colorvect_dot", 
          "vector": [ 0.707106781186548, 0, 0.707106781186548 ]
        }
      ], 
      "size": 10
    }'