result = cluster.query(
    """SELECT airportname, city
    FROM \`<BUCKET_NAME>\`.samples.airport
    WHERE city=$1;""",
    'London', QueryOptions(adhoc=false))