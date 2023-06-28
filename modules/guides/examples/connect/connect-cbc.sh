#!/usr/bin/env sh

# Will need to rewritten for Elixir

# tag::cbc-connect[]
cbc ping -u Administrator -P password -U couchbase://localhost/$DATABASE_NAME \
	--count=1 \
	--table
# end::cbc-connect[]

# tag::cbc-connect-cert[]
cbc ping -v -U "couchbases://127.0.0.1/$DATABASE_NAME?certpath=ca.pem" \
	--count=1 \
	--table
# end::cbc-connect-cert[]

# tag::cbc-connect-capella[]
cbc ping -u username -P "passworD#1" \
	-U "couchbases://cb.oawlpi4audpc6jp5.cloud.couchbase.com/$DATABASE_NAME?certpath=cert.pem" \
	--count=1 \
	--table
# end::cbc-connect-capella[]
