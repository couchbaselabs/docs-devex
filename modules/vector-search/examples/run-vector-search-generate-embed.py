#!/usr/bin/env python3

import os
import sys
from couchbase.cluster import Cluster
from couchbase.options import ClusterOptions
from couchbase.auth import PasswordAuthenticator
from couchbase.exceptions import CouchbaseException
import couchbase.search as search
from couchbase.options import SearchOptions
from couchbase.vector_search import VectorQuery, VectorSearch
from openai import OpenAI

# Change the question to whatever you want to ask
question = "What color hides everything like the night?"

# Make sure to replace OPENAI_API_KEY with your own API Key
openai_api_key = os.getenv("OPENAI_API_KEY")
client = OpenAI()

# Make sure to change CB_USERNAME, CB_PASSWORD, and CB_HOSTNAME to the username, password, and hostname for your database. 
pa = PasswordAuthenticator(os.getenv("CB_USERNAME"), os.getenv("CB_PASSWORD"))
cluster = Cluster("couchbases://" + os.getenv("CB_HOSTNAME") + "/?ssl=no_verify", ClusterOptions(pa))
# Make sure to change the bucket, scope, and index names to match where you stored the sample data in your database. 
bucket = cluster.bucket("vector-sample")
scope = bucket.scope("color")
search_index = "color-index"
try:
    vector = client.embeddings.create(input = [question], model="text-embedding-ada-002").data[0].embedding
    search_req = search.SearchRequest.create(search.MatchNoneQuery()).with_vector_search(
        VectorSearch.from_vector_query(VectorQuery('embedding_vector_dot', vector, num_candidates=2)))
        # Change the limit value to return more results. Change the fields array to return different fields from your Search index.
    result = scope.search(search_index, search_req, SearchOptions(limit=13,fields=["color", "description"]))
    for row in result.rows():
        print("Found row: {}".format(row))
    print("Reported total rows: {}".format(
        result.metadata().metrics().total_rows()))
except CouchbaseException as ex:
    import traceback
    traceback.print_exc()