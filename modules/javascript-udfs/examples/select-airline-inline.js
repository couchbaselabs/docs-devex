function selectAirline(country) {

    // SQL++ is written directly into the JavaScript code without the need
    // for a function call. 
    var q = SELECT name as airline_name, callsign as airline_callsign 
    FROM `travel-sample`.`inventory`.`airline` 
    WHERE country = $country;

    var res = [];

    for (const doc of q) {

        var airline = {}
        // Use a standard JavaScript iterator to access the values
        // from the SQL++ statement
        airline.name = doc.airline_name
        airline.callsign = doc.airline_callsign
        res.push(airline);

    }

    return res;

}
