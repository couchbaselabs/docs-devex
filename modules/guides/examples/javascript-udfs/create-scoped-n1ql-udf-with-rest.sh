curl -v http://localhost:8093/query/service \
  -u Administrator:password \
  -d 'statement=CREATE FUNCTION default:`<BUCKET_NAME>`.samples.GetBusinessDays(...)
  LANGUAGE JAVASCRIPT as "getBusinessDays" AT "<BUCKET_NAME>/samples/my-library"'
