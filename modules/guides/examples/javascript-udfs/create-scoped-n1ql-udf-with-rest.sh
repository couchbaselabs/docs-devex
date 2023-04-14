curl -v http://localhost:8093/query/service \
  -u Administrator:password \
  -d 'statement=CREATE FUNCTION default:`$DATABASE_NAME`.samples.GetBusinessDays(...)
  LANGUAGE JAVASCRIPT as "getBusinessDays" AT "$DATABASE_NAME/samples/my-library"'
