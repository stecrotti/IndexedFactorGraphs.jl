using IndexedFactorGraphs
using Test
using Aqua
using Graphs
using IndexedGraphs
using SparseArrays
using Random


@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all(IndexedFactorGraphs; ambiguities = false,)
    Aqua.test_ambiguities(IndexedFactorGraphs)
end

"""
Check type inference for functions that are likely to be called in hot loops
"""
function test_type_inference(g::AbstractFactorGraph)
    all_edges = @inferred edge_indices(g)
    i = rand(rng, @inferred eachvariable(g))
    a = rand(rng, @inferred eachfactor(g))
    di = @inferred degree(g, @inferred v_vertex(i))
    da = @inferred degree(g, @inferred f_vertex(a))
    ∂i = @inferred neighbors(g, v_vertex(i))
    inei = @inferred inedges(g, v_vertex(i))
    outei = @inferred outedges(g, v_vertex(i))
    ∂a = @inferred neighbors(g, f_vertex(a))
    inea = @inferred inedges(g, f_vertex(a))
    outea = @inferred outedges(g, f_vertex(a))
end

include("factorgraph.jl")
include("generators.jl")
include("infinite_regular_factorgraph.jl")

nothing