"""
    InfiniteRegularFactorGraph <: AbstractFactorGraph

A type to represent an infinite regular factor graph with fixed factor and variable degree
"""
struct InfiniteRegularFactorGraph{T<:Integer} <: AbstractFactorGraph{T}
    kᵢ :: T   # variable degree
    kₐ :: T   # factor degree

    function InfiniteRegularFactorGraph(kₐ::T, kᵢ::T) where {T<:Integer}
        kᵢ > 0 || throw(ArgumentError("Factor degree must be positive, got $kᵢ"))
        kₐ > 0 || throw(ArgumentError("Factor degree must be positive, got $kₐ"))
        return new{T}(kᵢ, kₐ)
    end
end

function Base.show(io::IO, g::InfiniteRegularFactorGraph{T}) where T
    println(io, "InfiniteRegularFactorGraph{$T} of variable degree $(g.kᵢ) and factor degree $(g.kₐ)")
end

nvariables(::InfiniteRegularFactorGraph) = 1
nfactors(::InfiniteRegularFactorGraph) = 1
Graphs.ne(::InfiniteRegularFactorGraph) = 1
Graphs.edges(::InfiniteRegularFactorGraph) = (IndexedEdge(1,1,1) for _ in 1:1)
variables(::InfiniteRegularFactorGraph) = 1:1
factors(::InfiniteRegularFactorGraph) = 1:1

IndexedGraphs.degree(g::InfiniteRegularFactorGraph, v::FactorGraphVertex) = length(neighbors(g, v))

function IndexedGraphs.neighbors(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{Factor})
    return Fill(1, g.kₐ)
end
function IndexedGraphs.neighbors(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{Variable})
    return Fill(1, g.kᵢ)
end
edge_indices(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{Factor}) = Fill(1, g.kₐ)
edge_indices(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{Variable}) = Fill(1, g.kᵢ)