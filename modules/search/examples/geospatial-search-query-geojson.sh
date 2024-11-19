curl -s -XPUT -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/${BUCKET-NAME}/scope/${SCOPE-NAME}/index/${INDEX-NAME}/query 
    -d '{
        "query": {
            "field": "geojson",
            "geometry": {
                "shape": {
                    "coordinates": [
                    [
                        [
                        -3.272607322511618,
                        53.94443025530833
                        ],
                        [
                        -3.369506040138134,
                        53.2576036482846
                        ],
                        [
                        -1.531900030030954,
                        53.352538254565076
                        ],
                        [
                        -0.08209172686298416,
                        53.568703110993994
                        ],
                        [
                        -0.4648577685729265,
                        53.86797332814126
                        ],
                        [
                        -1.612712602375666,
                        54.022352820673774
                        ],
                        [
                        -2.2803785770867933,
                        54.05470383755585
                        ],
                        [
                        -3.272607322511618,
                        53.94443025530833
                        ]
                    ]
                    ],
                    "type": "Polygon"
                },
                "relation": "within"
            }
        }
    }'