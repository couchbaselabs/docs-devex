from couchbase.cluster import Cluster, ClusterOptions
from couchbase.auth import PasswordAuthenticator
from couchbase.options import SearchOptions
from couchbase.search import MatchQuery, VectorQuery, Fusion

cluster = Cluster.connect(
    "couchbase://localhost",
    ClusterOptions(PasswordAuthenticator("user", "pass"))
)

query = MatchQuery("wireless headphones").field("description")
knn = VectorQuery(field="emb", vector=user_vec, k=200)

# --- RSF (Relative Score Fusion) ---
fusion_rsf = Fusion.rsf(
    # Enter the weights for your MatchQuery and your VectorQuery separately
    weights={"query": 0.6, "knn": 0.4} 
    score_window_size=200
)

res_rsf = cluster.search_query(
    "products_idx",
    (query, knn),
    SearchOptions(
        limit=20,
        fields=["id", "title", "brand"],
        # Use the settings defined in fusion_rsf to run an RSF hybrid query
        fusion=fusion_rsf
    ),
)
