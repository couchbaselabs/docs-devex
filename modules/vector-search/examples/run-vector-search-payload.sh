curl -XPOST -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/vector-sample/scope/color/index/color-index/query \
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
          "k": 3, 
          "field": "colorvect_l2", 
          "vector": [ 176, 0, 176 ]
        }
      ]
    }'