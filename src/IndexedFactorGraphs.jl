module IndexedFactorGraphs

using IndexedGraphs:
    IndexedGraphs, 
    IndexedEdge, IndexedGraph, BipartiteIndexedGraph, BipartiteGraphVertex, NullNumber,
    src, dst, idx, edges, nv, ne, degree, linearindex, inedges, outedges, vertex,
    nv_left, nv_right, vertex, Left, Right,
    rand_bipartite_graph, rand_regular_bipartite_graph, rand_bipartite_tree

using Graphs: Graphs, AbstractGraph, adjacency_matrix, neighbors, is_cyclic, prufer_decode

using FillArrays: Fill

using SparseArrays: sparse, SparseMatrixCSC, nzrange, nnz
using Random: AbstractRNG, default_rng
using StatsBase: sample

include("factorgraph.jl")
include("generators.jl")
include("infinite_regular_factorgraph.jl")

export AbstractFactorGraph, FactorGraph, nvariables, nfactors, eachvariable, eachfactor, f_vertex, v_vertex,
    pairwise_interaction_graph,
    neighbors, edges, src, dst, idx, ne, nv, degree,
    edge_indices, inedges, outedges,
    adjacency_matrix, is_cyclic
export rand_factor_graph, rand_regular_factor_graph, rand_tree_factor_graph
export InfiniteRegularFactorGraph

end