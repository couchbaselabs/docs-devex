import com.couchbase.client.core.error.*;
import com.couchbase.client.java.*;
import com.couchbase.client.java.kv.*;
import com.couchbase.client.java.json.*;
import com.couchbase.client.java.search.*;
import com.couchbase.client.java.search.queries.*;
import com.couchbase.client.java.search.result.*;
import com.couchbase.client.java.search.vector.*;

import java.time.Duration;
import java.util.Map;

public class RunVectorSearchSimpleColor {

    public static void main(String[] args) {

	String endpoint = "couchbases://" + System.getenv("CB_HOSTNAME") + "?tls_verify=none"; 
	String username = System.getenv("CB_USERNAME");
	String password = System.getenv("CB_PASSWORD");

	String bucketName = "vector-sample";
	String scopeName = "color";
	String collectionName = "rgb";
	String searchIndexName = "color-index";

	try {
	    // Connect to cluster with specified credentials
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

	    SearchRequest request = SearchRequest
	        .create(VectorSearch.create(
                    VectorQuery.create("colorvect_l2", new float[]{ 0.0f, 0.0f, 128.0f }
                ).numCandidates(3)));
	    SearchResult result = scope.search("color-index", request, 
                SearchOptions.searchOptions().limit(3).fields("color","brightness"));

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
