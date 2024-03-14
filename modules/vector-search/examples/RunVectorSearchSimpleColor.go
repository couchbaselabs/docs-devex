package main

import (
    "fmt"
    "log"
    "time"
    "os"
    "github.com/couchbase/gocb/v2"
    // "github.com/couchbase/gocb/v2/search"
    "github.com/couchbase/gocb/v2/vector"
)

func main() {
    connstr := "couchbases://" + os.Getenv("CB_HOSTNAME") 
    username := os.Getenv("CB_USERNAME")
    password := os.Getenv("CB_PASSWORD")
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
            vector.NewQuery("colorvect_l2", []float32{0.0, 0.0, 128.0}),
        },
        nil,
       ),
    }

    opts := &gocb.SearchOptions{Limit: 3, Fields: []string{"color"}}

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
