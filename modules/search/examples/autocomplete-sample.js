const couchbase = require('couchbase')

const main = async () => {
  const hostname = process.env.CB_HOSTNAME
  const username = process.env.CB_USERNAME
  const password = process.env.CB_PASSWORD
  const bucketName = 'travel-sample'

  const cluster = await couchbase.connect(hostname, {username: username, password: password })

  const ftsMatchPrefix = async (term) => {
    try {
      const result =  await cluster.searchQuery(
        "e-ngram-2-8",
        couchbase.SearchQuery.queryString(term), { limit: 8, fields: ["name"] }
      )
      result.rows.forEach((row) => { console.log(row.id,row.fields)})
    } catch (error) {
      console.error(error)
    }
  }

  const inputStr = "Beaufort Hotel"
  for (let i = 2; i <= 8; i++) {
    var testStr = inputStr.substring(0, i);
    console.log("Input <" + testStr + ">, len: " + testStr.length)
    const res = await ftsMatchPrefix(testStr)
  }
}

main()

