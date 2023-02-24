from couchbase.cluster import Cluster, ClusterOptions
from couchbase.auth import PasswordAuthenticator
from couchbase.exceptions import CouchbaseException
import couchbase.search as search
import os

username = os.getenv("$CB_USERNAME$", default=None)
password = os.getenv("$CB_PASSWORD$", default=None)
hostname = os.getenv("$CB_HOSTNAME$", default=None)

cluster = Cluster.connect(
    "couchbase://" + hostname,
    ClusterOptions(PasswordAuthenticator(username,password)))

try:
    inputStr = "Beaufort Hotel"
    for i in range(2, min(8,len(inputStr))):
        testStr = inputStr[0:i]
        print("Input <" + testStr + ">, len: " + str(len(testStr)));

        result = cluster.search_query(
            "e-ngram-2-8", 
            search.QueryStringQuery(testStr),
            search.SearchOptions(limit=8, fields=["name"]))

        for row in result.rows():
            print(row.id,row.fields)

except CouchbaseException as ex:
    import traceback
    traceback.print_exc()

