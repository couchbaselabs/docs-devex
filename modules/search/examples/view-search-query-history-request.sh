curl -s -H "Content-Type: application/json" \
    -u ${CB_USERNAME}:${CB_PASSWORD} http://${CB_HOSTNAME}:8094/api/searchHistory?limit=25&offset=0 \