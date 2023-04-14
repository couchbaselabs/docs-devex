var result = await cluster.QueryAsync<dynamic>(
    "select count(*) from `<bucket>`.samples.airport where country = ?",
    options =>
        options.Parameter("France")
        .AdHoc(false);
);