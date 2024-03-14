package main

import (
    "fmt"
    "log"
    "time"
    "os"
    "github.com/couchbase/gocb/v2"
    // "github.com/couchbase/gocb/v2/search"
    "github.com/couchbase/gocb/v2/vector"
    "bytes"
    "encoding/json"
    "io/ioutil"
    "net/http"
)

type OpenAIResponse struct {
    Data []struct {
        Embedding []float32 `json:"embedding"`
    } `json:"data"`
}

// generateVector makes a request to OpenAI's API to get an embedding vector for the given input text.
func generateVector(inputText string) ([]float32, error) {
    openaiAPIKey := os.Getenv("OPENAI_API_KEY")
    if openaiAPIKey == "" {
        return nil, fmt.Errorf("OPENAI_API_KEY environment variable is not set")
    }

    requestBody, err := json.Marshal(map[string]interface{}{
        "input":  inputText,
        "model": "text-embedding-ada-002",
    })
    if err != nil {
        return nil, fmt.Errorf("error marshaling request body: %w", err)
    }

    request, err := http.NewRequest("POST", "https://api.openai.com/v1/embeddings", bytes.NewBuffer(requestBody))
    if err != nil {
        return nil, fmt.Errorf("error creating request: %w", err)
    }

    request.Header.Set("Content-Type", "application/json")
    request.Header.Set("Authorization", "Bearer "+openaiAPIKey)

    client := &http.Client{}
    response, err := client.Do(request)
    if err != nil {
        return nil, fmt.Errorf("error making request: %w", err)
    }
    defer response.Body.Close()

    if response.StatusCode != http.StatusOK {
        bodyBytes, _ := ioutil.ReadAll(response.Body)
        return nil, fmt.Errorf("API request failed with status %d: %s", response.StatusCode, string(bodyBytes))
    }

    var openAIResponse OpenAIResponse
    if err := json.NewDecoder(response.Body).Decode(&openAIResponse); err != nil {
        return nil, fmt.Errorf("error decoding response: %w", err)
    }

    if len(openAIResponse.Data) == 0 || len(openAIResponse.Data[0].Embedding) == 0 {
        return nil, fmt.Errorf("no embedding vector found in response")
    }

    return openAIResponse.Data[0].Embedding, nil
}

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

    question := "What color hides everything like the night?"
    vect, err := generateVector(question)
    if err != nil {
        log.Fatalf("Error generating vector: %v", err)
    }

    request := gocb.SearchRequest{
        VectorSearch: vector.NewSearch(
            []*vector.Query{
            vector.NewQuery("embedding_vector_dot", vect),
        },
        nil,
       ),
    }

    opts := &gocb.SearchOptions{Limit: 2, Fields: []string{"color","description"}}

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
