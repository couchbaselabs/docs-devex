curl -s -XPUT -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/${BUCKET-NAME}/scope/${SCOPE-NAME}/index/${INDEX-NAME}/query 
    -d '{
      "from": 0,
      "size": 10,
      "query": {
        "location": {
          "lon": -2.235143,
          "lat": 53.482358
        },
          "distance": "100mi",
          "field": "geo"
        },
      "sort": [
        {
          "by": "geo_distance",
          "field": "geo",
          "unit": "mi",
          "location": {
          "lon": -2.235143,
          "lat": 53.482358
          }
        }
      ]
    }'