package main

import (
    "fmt"
    "log"
    "time"
    "os"
    "github.com/couchbase/gocb/v2"
    // Include this import if you want to run a Search query using regular Search index features.
    // "github.com/couchbase/gocb/v2/search"
    "github.com/couchbase/gocb/v2/vector"
)
// Make sure to change CB_USERNAME, CB_PASSWORD, and CB_HOSTNAME to the username, password, and hostname for your database.
func main() {
    connstr := "couchbases://" + os.Getenv("CB_HOSTNAME") 
    username := os.Getenv("CB_USERNAME")
    password := os.Getenv("CB_PASSWORD")
	// Make sure to change the bucket, and scope names to match where you stored the sample data in your database. 
    bucket_name := "vector-sample"
    scope_name := "color"

    cluster, err := gocb.Connect(connstr, gocb.ClusterOptions{
        Authenticator: gocb.PasswordAuthenticator{
            Username: username,
            Password: password,
        },
        SecurityConfig: gocb.SecurityConfig{
            TLSSkipVerify: true, // Disables TLS certificate verification
        },
    })
    if err != nil {
        log.Fatal(err)
    }

    bucket := cluster.Bucket(bucket_name)
    err = bucket.WaitUntilReady(5*time.Second, nil)
    if err != nil {
        log.Fatal(err)
    }

    scope := bucket.Scope(scope_name)

    request := gocb.SearchRequest{
        VectorSearch: vector.NewSearch(
            []*vector.Query{
			//  You can change the RGB values {0.0, 0.0, 128.0} to search for a different color.
            vector.NewQuery("colorvect_l2", []float32{0.0, 0.0, 128.0}),
        },
        nil,
       ),
    }
	// Change the limit value to return more results. Change the fields array to return different fields from your Search index.
    opts := &gocb.SearchOptions{Limit: 3, Fields: []string{"color"}}

	// Make sure to change the index name to match your Search index. 
    matchResult, err := scope.Search("color-index", request, opts)
    if err != nil {
        log.Fatal(err)
    }

    for matchResult.Next() {
        row := matchResult.Row()
        docID := row.ID
        var fields interface{}
        err := row.Fields(&fields)
        if err != nil {
            log.Fatal(err)
        }
        fmt.Printf("Document ID: %s, Fields: %v\n", docID, fields)
    }

    if err = matchResult.Err(); err != nil {
        log.Fatal(err)
    }
}