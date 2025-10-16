#!/bin/sh

# tag::query[]
curl -X POST "$BASEURL/_p/query/query/service" \
  -u $USER:$PASSWORD \
  -H 'Content-Type: application/json' \
  -d '{
  "statement": "UPDATE `travel-sample`.inventory.hotel
                SET price = \"from £89\"
                WHERE name = \"Glasgow Grand Central\";",
  "tximplicit": true
}'
# end::query[]