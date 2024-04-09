"""
    InfinteRegularFactorGraph <: AbstractFactorGraph

A type to represent an infinite regular factor graph with fixed factor and variable degree
"""
struct InfinteRegularFactorGraph{T<:Integer} <: AbstractFactorGraph{T}
    kᵢ :: T   # variable degree
    kₐ :: T   # factor degree

    function InfinteRegularFactorGraph(kₐ::T, kᵢ::T) where {T<:Integer}
        kᵢ > 0 || throw(ArgumentError("Factor degree must be positive, got $kᵢ"))
        kₐ > 0 || throw(ArgumentError("Factor degree must be positive, got $kₐ"))
        return new{T}(kᵢ, kₐ)
    end
end

function Base.show(io::IO, g::InfinteRegularFactorGraph{T}) where T
    println(io, "InfinteRegularFactorGraph{$T} of variable degree $(g.kᵢ) and factor degree $(g.kₐ)")
end

nvariables(::InfinteRegularFactorGraph) = 1
nfactors(::InfinteRegularFactorGraph) = 1
Graphs.ne(::InfinteRegularFactorGraph) = 1
Graphs.edges(::InfinteRegularFactorGraph) = (IndexedEdge(1,1,1) for _ in 1:1)
variables(::InfinteRegularFactorGraph) = 1:1
factors(::InfinteRegularFactorGraph) = 1:1

IndexedGraphs.degree(g::InfinteRegularFactorGraph, v::FactorGraphVertex) = length(neighbors(g, v))

function IndexedGraphs.neighbors(g::InfinteRegularFactorGraph, ::FactorGraphVertex{Factor})
    return Fill(1, g.kₐ)
end
function IndexedGraphs.neighbors(g::InfinteRegularFactorGraph, ::FactorGraphVertex{Variable})
    return Fill(1, g.kᵢ)
end
edge_indices(g::InfinteRegularFactorGraph, ::FactorGraphVertex{Factor}) = Fill(1, g.kₐ)
edge_indices(g::InfinteRegularFactorGraph, ::FactorGraphVertex{Variable}) = Fill(1, g.kᵢ)