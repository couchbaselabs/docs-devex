#!/bin/sh

# tag::request[]
curl -v -X POST -u Administrator:password \
http://localhost:8091/settings/querySettings/curlWhitelist \
-d '{"all_access": false,
     "allowed_urls": ["https://company1.com"],
     "disallowed_urls": ["https://company2.com"]}'
# end::request[]