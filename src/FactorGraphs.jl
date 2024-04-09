module FactorGraphs

using IndexedGraphs:
    AbstractIndexedGraph, IndexedGraph, IndexedEdge, BipartiteIndexedGraph, 
    BipartiteGraphVertex,
    NullNumber,
    src, dst, idx, edges, nv, ne, degree, linearindex,
    nv_left, nv_right, Left, Right
using IndexedGraphs

using Graphs: AbstractGraph, is_cyclic, prufer_decode
using Graphs

using FillArrays: Fill

using SparseArrays: sparse, SparseMatrixCSC, nzrange, nnz
using Random: AbstractRNG, default_rng
using StatsBase: sample

include("factorgraph.jl")
include("generators.jl")
include("infinite_regular_factorgraph.jl")

export FactorGraph, nvariables, nfactors, variables, factors, factor, variable,
    pairwise_interaction_graph,
    neighbors, edges, src, dst, idx, ne, nv, degree,
    edge_indices, inedges, outedges,
    adjacency_matrix, is_cyclic
export rand_factor_graph, rand_regular_factor_graph, rand_tree_factor_graph
export InfinteRegularFactorGraph

end