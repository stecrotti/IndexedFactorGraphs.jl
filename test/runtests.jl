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
    i = rand(rng, @inferred variables(g))
    a = rand(rng, @inferred factors(g))
    di = @inferred degree(g, @inferred variable(i))
    da = @inferred degree(g, @inferred factor(a))
    ∂i = @inferred neighbors(g, variable(i))
    inei = @inferred inedges(g, variable(i))
    outei = @inferred outedges(g, variable(i))
    ∂a = @inferred neighbors(g, factor(a))
    inea = @inferred inedges(g, factor(a))
    outea = @inferred outedges(g, factor(a))
end

include("factorgraph.jl")
include("generators.jl")
include("infinite_regular_factorgraph.jl")

nothing