var result = await cluster.QueryAsync<dynamic>(
    "select count(*) from `$DATABASE_NAME`.samples.airport where country = ?",
    options =>
        options.Parameter("France")
        .AdHoc(false);
);