curl -v http://localhost:8093/query/service \
  -u Administrator:password \
  -d 'statement=DROP FUNCTION default:`my-db`.`samples`.GetBusinessDays'