using FactorGraphs
using Test
using Aqua
using Graphs
using IndexedGraphs
using SparseArrays
using Random


@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all(FactorGraphs; ambiguities = false,)
    Aqua.test_ambiguities(FactorGraphs)
end

include("factorgraph.jl")
include("generators.jl")
include("infinite_regular_factorgraph.jl")

nothing