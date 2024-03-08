curl -s -XPUT -H "Content-Type: application/json" \
    -u $CB_USERNAME:$CB_PASSWORD https://$CB_HOSTNAME:18094/api/bucket/vector-sample/scope/color/index/color-index 
    -d \
  '{
    "type": "fulltext-index",
    "name": "vector-sample.color.color-index",
    "sourceType": "gocbcore",
    "sourceName": "vector-sample",
    "sourceUUID": "789365cccdf940ee2814a5dd2752040a",
    "planParams": {
      "maxPartitionsPerPIndex": 512,
      "indexPartitions": 1
    },
    "params": {
      "doc_config": {
        "docid_prefix_delim": "",
        "docid_regexp": "",
        "mode": "scope.collection.type_field",
        "type_field": "type"
      },
      "mapping": {
        "analysis": {},
        "default_analyzer": "standard",
        "default_datetime_parser": "dateTimeOptional",
        "default_field": "_all",
        "default_mapping": {
          "dynamic": false,
          "enabled": false
        },
        "default_type": "_default",
        "docvalues_dynamic": false,
        "index_dynamic": false,
        "store_dynamic": false,
        "type_field": "_type",
        "types": {
        "color.rgb": {
          "dynamic": false,
          "enabled": true,
          "properties": {
            "brightness": {
              "dynamic": false,
              "enabled": true,
              "fields": [
                {
                  "index": true,
                  "name": "brightness",
                  "store": true,
                  "type": "number"
                }
              ]
            },
            "color": {
              "dynamic": false,
              "enabled": true,
              "fields": [
                {
                  "analyzer": "en",
                  "index": true,
                  "name": "color",
                  "store": true,
                  "type": "text"
                }
              ]
            },
            "colorvect_dot": {
              "dynamic": false,
              "enabled": true,
              "fields": [
                {
                  "dims": 3,
                  "index": true,
                  "name": "colorvect_dot",
                  "similarity": "dot_product",
                  "type": "vector"
                }
              ]
            },
            "colorvect_l2": {
              "dynamic": false,
              "enabled": true,
              "fields": [
                {
                  "dims": 3,
                  "index": true,
                  "name": "colorvect_l2",
                  "similarity": "l2_norm",
                  "type": "vector"
                }
              ]
            },
            "description": {
              "dynamic": false,
              "enabled": true,
              "fields": [
                {
                  "analyzer": "en",
                  "index": true,
                  "name": "description",
                  "store": true,
                  "type": "text"
                }
              ]
            },
            "embedding_vector_dot": {
              "dynamic": false,
              "enabled": true,
              "fields": [
                {
                  "dims": 1536,
                  "index": true,
                  "name": "embedding_vector_dot",
                  "similarity": "dot_product",
                  "type": "vector"
                }
              ]
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