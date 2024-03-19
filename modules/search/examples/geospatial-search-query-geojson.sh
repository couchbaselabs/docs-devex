curl -s -XPUT -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/${BUCKET-NAME}/scope/${SCOPE-NAME}/index/${INDEX-NAME}/query 
    -d '{
        "query": {
            "field": "geojson",
            "geometry": {
                "shape": {
                    "type": "Polygon",
                    "coordinates": [
                        [
                        [
                            0.47482593026924746,
                            51.31232878073189
                        ],
                        [
                            0.6143265647863245,
                            51.31232878073189
                        ],
                        [
                            0.6143265647863245,
                            51.384000374770466
                        ],
                        [
                            0.47482593026924746,
                            51.384000374770466
                        ],
                        [
                            0.47482593026924746,
                            51.31232878073189
                        ]
                        ]
                    ]
                },
                "relation": "within"
            }
        }
    }