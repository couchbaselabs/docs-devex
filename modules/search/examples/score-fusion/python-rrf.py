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

# --- RRF (Reciprocal Rank Fusion) ---
fusion_rrf = Fusion.rrf(
    score_rank_constant =60,
    # Enter the weights for your MatchQuery and your VectorQuery separately
    weights={"query": 0.6, "knn": 0.4} 
    score_window_size=200
)

res_rrf = cluster.search_query(
    "products_idx",
    (query, knn),
    SearchOptions(
        limit=20,
        fields=["id", "title", "brand"],
        # Use the settings defined in fusion_rrf to run an RRF hybrid query
        fusion=fusion_rrf
    ),
)
