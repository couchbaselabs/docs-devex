#!/usr/bin/env nu

# tag::cbsh-kv-insert[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel
doc insert hotel-123 {
  "id": 123,
  "name": "Medway Youth Hostel",
  "address": "Capstone Road, ME7 3JE",
  "url": "http://www.yha.org.uk",
  "geo": {
    "lat": 51.35785,
    "lon": 0.55818,
    "accuracy": "RANGE_INTERPOLATED"
  },
  "country": "United Kingdom",
  "city": "Medway",
  "state": null,
  "reviews": [
    {
      "content": "This was our 2nd trip here and we enjoyed it more than last year.", 
      "author": "Ozella Sipes",
      "date": "2021-11-17T17:35:05.351Z"
    }
  ],
  "vacancy": true,
  "description": "40 bed summer hostel about 3 miles from Gillingham."
}
# end::cbsh-kv-insert[]

# tag::cbsh-kv-insert-expiry[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel
doc insert --expiry 60 hotel-456 {
  "id": 456,
  "title": "Ardèche",
  "name": "La Pradella",
  "address": "rue du village, 07290 Preaux, France",
  "phone": "+33 4 75 32 08 52",
  "url": "http://www.lapradella.fr", 
  "country": "France",
  "city": "Preaux",
  "state": "Rhône-Alpes",
  "vacancy": false
}
# end::cbsh-kv-insert-expiry[]

# tag::cbsh-kv-get[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel
doc get hotel-123
# end::cbsh-kv-get[]

# tag::cbsh-kv-get-with-opts[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel
doc get hotel-123 | to json
# end::cbsh-kv-get-with-opts[]

# tag::cbsh-kv-upsert[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel
doc upsert hotel-123 {
  "id": 123,
  "name": "Medway Youth Hostel",
  "address": "Capstone Road, ME7 3JE",
  "url": "http://www.yha.org.uk",
  "country": "United Kingdom",
  "city": "Medway",
  "state": null,
  "vacancy": true,
  "description": "40 bed summer hostel about 3 miles from Gillingham."
}
# end::cbsh-kv-upsert[]

# tag::cbsh-kv-replace[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel
doc replace hotel-123 {
  "id": 123,
  "name": "Medway Youth Hostel",
  "address": "Capstone Road, ME7 3JE",
  "url": "http://www.yha.org.uk",
  "geo": {
    "lat": 51.35785,
    "lon": 0.55818,
    "accuracy": "RANGE_INTERPOLATED"
  },
  "country": "United Kingdom",
  "city": "Medway",
  "state": null,
  "reviews": [
    {
      "content": "This was our 2nd trip here and we enjoyed it more than last year.",
      "author": "Ozella Sipes",
      "date": "2021-12-13T17:38:02.935Z"
    },
    {
      "content": "This hotel was cozy, conveniently located and clean.",
      "author": "Carmella O'Keefe",
      "date": "2021-12-13T17:38:02.974Z"
    }
  ],
  "vacancy": true,
  "description": "40 bed summer hostel about 3 miles from Gillingham."
}
# end::cbsh-kv-replace[]

# tag::cbsh-kv-delete[]
cb-env bucket travel-sample
cb-env scope inventory
cb-env collection hotel
doc remove hotel-123
# end::cbsh-kv-delete[]

# tag::cbsh-bulk-insert[]
cb-env bucket travel-sample
cb-env scope tenant_agent_00
cb-env collection users
[
  {id: "user_111", email: "tom_the_cat@example.com"},
  {id: "user_222", email: "jerry_mouse@example.com"},
  {id: "user_333", email: "mickey_mouse@example.com"}
] | wrap content | insert id { |this| echo $this.content.id } | doc insert
# end::cbsh-bulk-insert[]

# tag::cbsh-bulk-get[]
cb-env bucket travel-sample
cb-env scope tenant_agent_00
cb-env collection users
['0' '1'] | wrap id | doc get
# end::cbsh-bulk-get[]

# tag::cbsh-bulk-upsert[]
cb-env bucket travel-sample
cb-env scope tenant_agent_00
cb-env collection users
[
  {id: "user_111", email: "tom@example.com"},
  {id: "user_222", email: "jerry@example.com"},
  {id: "user_333", email: "mickey@example.com"}
] | wrap content | insert id { |this| echo $this.content.id } | doc upsert
# end::cbsh-bulk-upsert[]

# tag::cbsh-bulk-delete[]
cb-env bucket travel-sample
cb-env scope tenant_agent_00
cb-env collection users
[user_111 user_222 user_333] | wrap id | doc remove
# end::cbsh-bulk-delete[]
