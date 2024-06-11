#!/usr/bin/env nu

# tag::cbsh-subdoc-get[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel

doc get hotel-123 | get content.geo
# end::cbsh-subdoc-get[]

# tag::cbsh-subdoc-upsert[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel

doc get hotel-123 | upsert content.pets_ok true | doc replace
# end::cbsh-subdoc-upsert[]

# tag::cbsh-subdoc-reject[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel

doc get hotel-123 | reject content.url | doc replace
# end::cbsh-subdoc-reject[]
