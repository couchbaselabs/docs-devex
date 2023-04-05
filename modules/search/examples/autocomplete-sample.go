package main

import (
    "os"
    "fmt"
    "math"
    "log"
    "github.com/couchbase/gocb/v2"
    "github.com/couchbase/gocb/v2/search"
)

func main() {
    cluster, err := gocb.Connect(
	os.Getenv("CB_HOSTNAME"),                    
	gocb.ClusterOptions{
        Authenticator: gocb.PasswordAuthenticator{
            Username: os.Getenv("CB_USERNAME"),      
            Password: os.Getenv("CB_PASSWORD"),      
        },
    })
    if err != nil {
        log.Fatal(err)
    }

    iterStr := "Beaufort Hotel"
    maxsz := int(math.Min(float64(len(iterStr)), float64(8)))
    for i := 2;  i <= maxsz; i++ {
        testStr := iterStr[0:i]
	fmt.Printf("Input <%s>, len: %d\n", testStr, len(testStr));
	results, err := cluster.SearchQuery(
	    "e-ngram-2-8",
	    search.NewQueryStringQuery(testStr), 
	    &gocb.SearchOptions { Fields: []string{"name"}, Limit: 8, },
	)
	if err != nil {
	    log.Fatal(err)
	}

	for results.Next() {
	    row := results.Row()
	    docID := row.ID
	    var fields interface {}
	    err := row.Fields( & fields)
	    if err != nil {
		panic(err)
	    }
	    fmt.Printf("Document ID: %s, fields: %v\n", docID, fields)
	}

	err = results.Err()
	if err != nil {
	    log.Fatal(err)
	}
    }
}
