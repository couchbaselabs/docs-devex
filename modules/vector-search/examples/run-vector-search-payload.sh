curl -XPOST -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} https://${CB_HOSTNAME}:18094/api/bucket/vector-sample/scope/color/index/color-index/query \
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
          "field": "colorvect_l2", 
          "vector": [ 176, 0, 176 ]
        }
      ]
    }'