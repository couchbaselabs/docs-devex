curl -v http://localhost:8093/query/service \
  -u Administrator:password \
  -d 'statement=CREATE FUNCTION default:`my-db`.samples.GetBusinessDays(...)
  LANGUAGE JAVASCRIPT as "getBusinessDays" AT "my-db/samples/my-library"'
