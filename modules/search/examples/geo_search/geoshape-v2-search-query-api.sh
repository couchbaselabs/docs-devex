curl -s -XPOST -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/${BUCKET-NAME}/scope/${SCOPE-NAME}/index/${INDEX-NAME}/query 
    -d '{
          "query": {
            "field": "geojson",
            "geometry_v2": {
              "shape": {
                "coordinates": [
                  [
                    [
                      -3.272607,
                      53.94443
                    ],
                    [
                      -3.369506,
                      53.257604
                    ],
                    [
                      -1.5319,
                      53.352538
                    ],
                    [
                      -0.082092,
                      53.568703
                    ],
                    [
                      -0.464858,
                      53.867973
                    ],
                    [
                      -1.612713,
                      54.022353
                    ],
                    [
                      -2.280379,
                      54.054704
                    ],
                    [
                      -3.272607,
                      53.94443
                    ]
                  ]
                ],
                "type": "Polygon"
              },
              "relation": "within"
            }
          },
          "explain": true,
          "size": 10,
          "from": 0
        }'