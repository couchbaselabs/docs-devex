#!/bin/sh

# tag::curl[]
curl $BASE_URL/admin/settings -u $USER:$PASSWORD -o ./query_settings.json
# end::curl[]