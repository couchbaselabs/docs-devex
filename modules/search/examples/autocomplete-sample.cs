using Couchbase;
using Couchbase.Search.Queries.Simple;

await using var cluster = await Cluster.ConnectAsync(new ClusterOptions
{
    ConnectionString = "$CB_HOSTNAME$",
    UserName = "$CB_USERNAME$",
    Password = "$CB_PASSWORD$",
    Buckets = new List<string>{"travel-sample"}
}.ApplyProfile("wan-development"));

var searchString = "Beaufort Hotel";
for (var i = 2; i <= 8; i++)
{
    var lettersEntered = searchString.Substring(0, i);
    Console.WriteLine($"Input <{lettersEntered}>, len: {lettersEntered.Length}");
    await FtsMatchPrefix(lettersEntered);
}

async Task FtsMatchPrefix(string letters)
{
    try
    {
        var results = await cluster.SearchQueryAsync("e-ngram-2-8",
            new QueryStringQuery(letters),
            options =>
            {
                options.Limit(8);
                options.Fields("name");
            });
        results.Hits.ToList().ForEach(row => { Console.WriteLine($"{row.Id}, {row.Fields}"); });
        Console.WriteLine(results);
    }
    catch (Exception e)
    {
        Console.WriteLine(e);
    }
}