curl -v http://localhost:8093/query/service \
  -u Administrator:password \
  -d 'statement=DROP FUNCTION default:`$DATABASE_NAME`.`samples`.GetBusinessDays'