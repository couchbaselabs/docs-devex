import com.couchbase.client.java.Cluster;
import com.couchbase.client.java.json.JsonObject;
import com.couchbase.client.java.search.SearchOptions;
import com.couchbase.client.java.search.SearchQuery;
import com.couchbase.client.java.search.result.SearchResult;
import com.couchbase.client.java.search.result.SearchRow;

public class MockTypeAheadEnGram {
  static String connstrn = System.getenv("$CB_HOSTNAME$"); 
  static String username = System.getenv("$CB_USERNAME$"); 
  static String password = System.getenv("$CB_PASSWORD$"); 
  
  public static void main(String... args) {
    Cluster cluster = Cluster.connect(connstrn, username, password);
    
    String iterStr = "Beaufort Hotel";
    for (int i=2; i<=Math.min(8, iterStr.length());i++) {
    	String testStr = iterStr.substring(0, i);
    	System.out.println("Input <" + testStr + ">, len: " + testStr.length());
    
    	SearchQuery query = SearchQuery.queryString(testStr);
    	SearchOptions options = SearchOptions.searchOptions().limit(8).skip(0).explain(false).fields("name");
    	SearchResult result = cluster.searchQuery("e-ngram-2-8" , query, options);
    	for (SearchRow row : result.rows()) {
    		System.out.println(row.id() + "," + row.fieldsAs(JsonObject.class) );
    	}
    }
  }
}
