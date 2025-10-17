# This script just iterates over all of the colors in the example dataset to find cases
# where reranking improved the search results. 

import sys
from couchbase.cluster import Cluster, ClusterOptions
from couchbase.auth import PasswordAuthenticator
from couchbase.options import QueryOptions
from datetime import timedelta


# --- Configuration ---
COUCHBASE_URL = "couchbase://localhost"
USERNAME = "Administrator"
PASSWORD = "password"
BUCKET_NAME = "color-vector-sample"

# --- Connect to Cluster ---
cluster = Cluster(COUCHBASE_URL, ClusterOptions(PasswordAuthenticator(USERNAME, PASSWORD)))
cluster.wait_until_ready(timedelta(seconds=10))

# --- Get all search-color IDs ---
get_ids_query = "SELECT META().id AS id FROM `color-vector-sample`.`color`.`rgb`"
search_colors = cluster.query(get_ids_query)
search_color_ids = [row["id"] for row in search_colors]

# --- Function to run vector queries ---
def run_vector_query(search_color_id, use_rerank=False, limit=10):
    rerank_str = "TRUE" if use_rerank else "FALSE"
    query = f"""
    WITH question_vec AS (
        SELECT RAW couchbase_search_query.knn[0].vector  
        FROM `color-vector-sample`.`color`.`rgb-questions` 
        WHERE meta().id = "{search_color_id}")
    SELECT b.color, b.description, b.id
    FROM `color-vector-sample`.`color`.`rgb` AS b
    ORDER BY APPROX_VECTOR_DISTANCE(b.embedding_vector_dot, question_vec[0], "l2", 4, {rerank_str})
    LIMIT {limit};
    """
    return list(cluster.query(query))

# --- Analyze and compare results ---
for search_color_id in search_color_ids:
    # print(f"\n🔍 Search Color: {search_color_id}")

    try:
        # Run both queries
        results1 = run_vector_query(search_color_id, use_rerank=False)
        results2 = run_vector_query(search_color_id, use_rerank=True)
    except Exception as e:
        print(f"⚠️ Query error for {search_color_id}: {e}")
        continue

    ids1 = [doc["id"] for doc in results1]
    ids2 = [doc["id"] for doc in results2]

    in_both = search_color_id in ids1 and search_color_id in ids2

    if in_both:
        idx1 = ids1.index(search_color_id)
        idx2 = ids2.index(search_color_id)
        if idx2 < idx1:
            print(f"✅ Reranking improved rank for {search_color_id}: {idx1} ➜ {idx2}")
            # sys.exit(0)
        # else:
        #    print(f"→ No improvement (Rank: {idx1} ➜ {idx2})")
    # else:
    #    if search_color_id in ids1:
    #        print("⚠️ Present only in first query, not in reranked results.")
    #    elif search_color_id in ids2:
    #        print("⚠️ Present only in reranked results, not in first query.")
    #    else:
    #        print("❌ Not present in either result set.")

# --- Final Message ---
# print("\n❌ Reranking did not improve the rank of any search-color.")
