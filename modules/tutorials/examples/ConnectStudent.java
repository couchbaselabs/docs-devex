import com.couchbase.client.java.Bucket;
import com.couchbase.client.java.Cluster;
import com.couchbase.client.java.Collection;
import com.couchbase.client.java.Scope;

import java.time.Duration;

public class ConnectStudent {

    public static void main(String[] args) {

        // Calls `Cluster.connect` to create a channel to the named server 
        // (in this case, `localhost` is running on your local machine)
        // and supplies your username and password to authenticate the connection.
        Cluster cluster = Cluster.connect("localhost",
                "username", "password"); 

        // The `cluster.bucket` retrieves the bucket you set up when you installed Couchbase Server.
        Bucket bucket = cluster.bucket("student-bucket");  

        // Most of the Couchbase APIs are non-blocking. 
        // When you call one of them, your application carries on and continues to perform other actions while the function you called executes. 
        // When the function has finished executing, it sends a notification to the caller and the output of the call is processed.
        // While this usually works, in this code sample the application carries on without waiting for the bucket retrieval to complete after you make the call to `cluster.bucket`. 
        // This means that you now have to try to retrieve the scope from a bucket object that has not been fully initialized yet. 
        // To fix this, you can use the `waitUntilReady` call. 
        // This call forces the application to wait until the bucket object is ready.
        bucket.waitUntilReady(Duration.ofSeconds(10));  

        // The `bucket.scope` retrieves the `art-school-scope` from the bucket.
        Scope scope = bucket.scope("art-school-scope");   

        // The `scope.collection` retrieves the student collection from the scope.
        Collection student_records = scope.collection("student-record-collection"); 

        // A check to make sure the collection is connected and retrieved when you run the application. 
        // You can see the output using maven.
        System.out.println("The name of this collection is " + student_records.name()); 

        // Like with all database systems, it's good practice to disconnect from the Couchbase cluster after you have finished working with it.
        cluster.disconnect();
    }
}