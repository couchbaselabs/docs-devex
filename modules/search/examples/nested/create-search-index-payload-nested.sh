curl -s -XPUT -H "Content-Type: application/json" \
  -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/bucket/travel-sample/scope/inventory/index/travel-sample-nested-index 
  -d \
  '{
    "name": "travel-sample-nested-index",
    "type": "fulltext-index",
    "params": {
      "doc_config": {
        "docid_prefix_delim": "",
        "docid_regexp": "",
        "mode": "scope.collection.type_field",
        "type_field": "type"
      },
      "mapping": {
        "default_analyzer": "standard",
        "default_datetime_parser": "dateTimeOptional",
        "default_field": "_all",
        "default_mapping": {
          "dynamic": true,
          "enabled": false
      },
      "default_type": "_default",
      "docvalues_dynamic": true,
      "index_dynamic": true,
      "scoring_model": "tf-idf",
      "store_dynamic": true,
      "type_field": "_type",
      "types": {
        "inventory.hotel": {
          "dynamic": false,
          "enabled": true,
          "properties": {
            "reviews": {
              "dynamic": true,
              "enabled": true,
              "nested": true
            },
            "name": {
              "enabled": true,
              "dynamic": false,
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
            }
          }
        }
      }
      },
      "store": {
        "indexType": "scorch",
        "segmentVersion": 17
      }
    },
    "sourceType": "gocbcore",
    "sourceName": "travel-sample",
    "sourceParams": {
      "scopeParams": {
        "collections": [
          {
          "name": "hotel"
          }
        ],
        "name": "inventory"
      }
    },
    "planParams": {
      "maxPartitionsPerPIndex": 128,
      "indexPartitions": 1,
      "numReplicas": 0
  }
}'