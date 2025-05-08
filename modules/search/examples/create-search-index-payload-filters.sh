curl -s -XPUT -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/travel-sample/scope/inventory/index/travel-sample-filter-index 
  -d \
  '{
    "type": "fulltext-index",
    "name": "travel-sample.inventory.travel-sample-filter",
    "sourceType": "gocbcore",
    "sourceName": "travel-sample",
    "planParams": {
      "maxPartitionsPerPIndex": 128,
      "indexPartitions": 1
    },
    "params": {
      "doc_config": {
        "doc_filter": {
          "cleanliness_AND_free_breakfast": {
            "conjuncts": [
              {
                "field": "reviews.ratings.Cleanliness",
                "inclusive_max": true,
                "max": 5,
                "min": 3
              },
              {
                "bool": true,
                "field": "free_breakfast"
              }
            ],
            "order": 1
          }
        },
        "docid_prefix_delim": "",
        "docid_regexp": "",
        "mode": "scope.collection.custom",
        "type_field": "type"
      },
      "mapping": {
        "analysis": {},
        "default_analyzer": "standard",
        "default_datetime_parser": "dateTimeOptional",
        "default_field": "_all",
        "default_mapping": {
          "dynamic": true,
          "enabled": false
        },
        "default_type": "_default",
        "docvalues_dynamic": false,
        "index_dynamic": true,
        "store_dynamic": false,
        "type_field": "_type",
        "types": {
          "inventory.hotel.cleanliness_AND_free_breakfast": {
            "dynamic": false,
            "enabled": true,
            "properties": {
              "description": {
                "dynamic": false,
                "enabled": true,
                "fields": [
                  {
                    "docvalues": true,
                    "include_in_all": true,
                    "include_term_vectors": true,
                    "index": true,
                    "name": "description",
                    "store": true,
                    "type": "text"
                  }
                ]
              },
              "free_breakfast": {
                "dynamic": false,
                "enabled": true,
                "fields": [
                  {
                    "docvalues": true,
                    "include_in_all": true,
                    "index": true,
                    "name": "free_breakfast",
                    "store": true,
                    "type": "boolean"
                  }
                ]
              },
              "name": {
                "dynamic": false,
                "enabled": true,
                "fields": [
                  {
                    "docvalues": true,
                    "include_in_all": true,
                    "include_term_vectors": true,
                    "index": true,
                    "name": "name",
                    "store": true,
                    "type": "text"
                  }
                ]
              },
              "reviews": {
                "dynamic": false,
                "enabled": true,
                "properties": {
                  "content": {
                    "dynamic": false,
                    "enabled": true,
                    "fields": [
                      {
                        "docvalues": true,
                        "include_in_all": true,
                        "include_term_vectors": true,
                        "index": true,
                        "name": "content",
                        "store": true,
                        "type": "text"
                      }
                    ]
                  },
                  "ratings": {
                    "dynamic": false,
                    "enabled": true,
                    "properties": {
                      "Cleanliness": {
                        "dynamic": false,
                        "enabled": true,
                        "fields": [
                          {
                            "docvalues": true,
                            "include_in_all": true,
                            "index": true,
                            "name": "Cleanliness",
                            "store": true,
                            "type": "number"
                          }
                        ]
                      }
                    }
                  }
                }
              }
            }
          }
        }
      },
      "store": {
        "indexType": "scorch",
        "segmentVersion": 16
      }
    },
    "sourceParams": {}
  }'