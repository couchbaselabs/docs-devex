result = cluster.query(
    """SELECT airportname, city
    FROM \`<bucket>\`.samples.airport
    WHERE city=$1;""",
    'London', QueryOptions(adhoc=false))