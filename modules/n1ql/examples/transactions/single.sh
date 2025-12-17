#!/bin/sh

# tag::query[]
curl -X POST "$BASEURL/_p/query/query/service" \
  -u $USER:$PASSWORD \
  -H 'Content-Type: application/json' \
  -d '{
  "statement": "UPDATE hotel SET price = \"from £89\" WHERE name = \"Glasgow Grand Central\";",
  "query_context": "`travel-sample`.inventory",
  "tximplicit": true
}'
# end::query[]