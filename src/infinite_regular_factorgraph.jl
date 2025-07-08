"""
    InfiniteRegularFactorGraph <: AbstractFactorGraph

A type to represent an infinite regular factor graph with fixed factor and variable degree
"""
struct InfiniteRegularFactorGraph{T<:Integer} <: AbstractFactorGraph{T}
    kᵢ :: T   # variable degree
    kₐ :: T   # factor degree

    @doc """
        InfiniteRegularFactorGraph(kᵢ, kₐ)

    Construct an `InfiniteRegularFactorGraph` with variable degree `kᵢ` and factor degree `kₐ`
    """
    function InfiniteRegularFactorGraph(kᵢ::T, kₐ::T) where {T<:Integer}
        kᵢ > 0 || throw(ArgumentError("Variable degree must be positive, got $kᵢ"))
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
eachvariable(::InfiniteRegularFactorGraph) = 1:1
eachfactor(::InfiniteRegularFactorGraph) = 1:1

IndexedGraphs.degree(g::InfiniteRegularFactorGraph, v::FactorGraphVertex) = length(neighbors(g, v))

function IndexedGraphs.neighbors(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{FactorVertex})
    return Fill(1, g.kₐ)
end
function IndexedGraphs.neighbors(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{VariableVertex})
    return Fill(1, g.kᵢ)
end

edge_indices(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{FactorVertex}) = Fill(1, g.kₐ)
edge_indices(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{VariableVertex}) = Fill(1, g.kᵢ)

function IndexedGraphs.inedges(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{FactorVertex})
    return (IndexedEdge(1,1,1) for _ in 1:g.kₐ)
end
function IndexedGraphs.inedges(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{VariableVertex})
    return (IndexedEdge(1,1,1) for _ in 1:g.kᵢ)

end
function IndexedGraphs.outedges(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{FactorVertex})
    return (IndexedEdge(1,1,1) for _ in 1:g.kₐ)
end
function IndexedGraphs.outedges(g::InfiniteRegularFactorGraph, ::FactorGraphVertex{VariableVertex})
    return (IndexedEdge(1,1,1) for _ in 1:g.kᵢ)
end