import com.couchbase.client.core.error.*;
import com.couchbase.client.java.*;
import com.couchbase.client.java.kv.*;
import com.couchbase.client.java.json.*;
import com.couchbase.client.java.search.*;
import com.couchbase.client.java.search.queries.*;
import com.couchbase.client.java.search.result.*;
import com.couchbase.client.java.search.vector.*;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.List;

import java.time.Duration;
import java.util.Map;

public class RunVectorSearchGenerateEmbed {
    // Make sure to replace OPENAI_API_KEY with your own API Key.
    private static final String OPENAI_API_KEY = System.getenv("OPENAI_API_KEY");
    private static final String OPENAI_URL = "https://api.openai.com/v1/embeddings";

    public static float[] generateVector(String inputText) {
        HttpClient client = HttpClient.newHttpClient();

        JsonObject jsonBody = JsonObject.create()
                .put("input", inputText)
                .put("model", "text-embedding-ada-002");

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(OPENAI_URL))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + OPENAI_API_KEY)
                .POST(HttpRequest.BodyPublishers.ofString(jsonBody.toString()))
                .build();

        try {
            HttpResponse<String> response = client.send(request, BodyHandlers.ofString());

            JsonObject jsonResponse = JsonObject.fromJson(response.body());
            List<Object> embeddingList = jsonResponse.getArray("data")
                .getObject(0)
                .getArray("embedding")
                .toList();

            return toFloatArray(embeddingList);
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return null; // or handle more gracefully
        }
    }

    private static float[] toFloatArray(List<Object> list) {
        float[] result = new float[list.size()];
        for (int i = 0; i < list.size(); i++) {
            result[i] = ((Number) list.get(i)).floatValue();
        }
        return result;
    }

    public static void main(String[] args) {
// Make sure to change CB_USERNAME, CB_PASSWORD, and CB_HOSTNAME to the username, password, and hostname for your database.
	String endpoint = "couchbases://" + System.getenv("CB_HOSTNAME") + "?tls_verify=none"; 
	String username = System.getenv("CB_USERNAME");
	String password = System.getenv("CB_PASSWORD");
// Make sure to change the bucket, scope, collection, and index names to match where you stored the sample data in your database. 
	String bucketName = "vector-sample";
	String scopeName = "color";
	String collectionName = "rgb";
	String searchIndexName = "color-index";

	try {
	    // Connect to database/cluster with specified credentials
	    Cluster cluster = Cluster.connect(
		    endpoint,
		    ClusterOptions.clusterOptions(username, password).environment(env -> {
			    // Use the pre-configured profile below to avoid latency issues with your connection.
			    env.applyProfile("wan-development");
		    })
	    );

	    Bucket bucket = cluster.bucket(bucketName);
	    bucket.waitUntilReady(Duration.ofSeconds(10));
	    Scope scope = bucket.scope(scopeName);
	    Collection collection = scope.collection(collectionName);
            // Change the question to whatever you want to ask.
            String question = "What color hides everything like the night?";
            float[] vector = generateVector(question);

	    SearchRequest request = SearchRequest
	        .create(VectorSearch.create(
                    VectorQuery.create("embedding_vector_dot", vector).numCandidates(2)));
        // Make sure to change the index name to match your Search index. 
	    SearchResult result = scope.search("color-index", request,
        // Change the limit value to return more results. Change the value or values in fields to return different fields from your Search index.
                SearchOptions.searchOptions().limit(3).fields("color","description"));

	    for (SearchRow row : result.rows()) {
	      System.out.println("Found row: " + row);
	      System.out.println("   Fields: " + row.fieldsAs(Map.class));
	    } 

	} catch (UnambiguousTimeoutException ex) {
	    boolean authFailure = ex.toString().contains("Authentication Failure");
	    if (authFailure) {
		    System.out.println("Authentication Failure Detected");
	    } else {
		    System.out.println("Error:");
		    System.out.println(ex.getMessage());
	    }
	}
    }
}