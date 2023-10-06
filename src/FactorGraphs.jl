module FactorGraphs

using IndexedGraphs:
    AbstractIndexedGraph, IndexedGraph, IndexedEdge, BipartiteIndexedGraph, 
    BipartiteGraphVertex,
    NullNumber,
    src, dst, idx, edges, nv, ne, 
    nv_left, nv_right, Left, Right
    
using IndexedGraphs
using SparseArrays: sparse, SparseMatrixCSC, nzrange

const Factor = Left
const Variable = Right

"""
    factor(a::Integer)

Wraps index `a` in a container such that other functions like [`neighbors`](@ref), [`inedges`](@ref) etc. know that it indices a factor node.
"""
factor(a::Integer) = vertex(a, Factor)

"""
    variable(i::Integer)

Wraps index `i` in a container such that other functions like [`neighbors`](@ref), [`inedges`](@ref) etc. know that it indices a variable node.
"""
variable(i::Integer) = vertex(i, Variable)

"""
    FactorGraph{T}

A type representing a [factor graph](https://en.wikipedia.org/wiki/Factor_graph).
"""
struct FactorGraph{T}
    g :: BipartiteIndexedGraph{T}
end
"""
    FactorGraph(A::AbstractMatrix)

Construct a `FactorGraph` from adjacency matrix `A` with the convention that rows are factors, columns are variables
"""
function FactorGraph(A::AbstractMatrix)
    A = sparse(A)
    g = BipartiteIndexedGraph(SparseMatrixCSC(A.m, A.n, A.colptr, A.rowval, fill(NullNumber(), length(A.nzval))))
	FactorGraph(g)
end

"""
    pairwise_interaction_graph(g::IndexedGraph)

Construct a factor graph whose factors are the pair-wise interactions encoded in `g`.
"""
function pairwise_interaction_graph(g::IndexedGraph)
    I = reduce(vcat, [idx(e), idx(e)] for e in edges(g)) 
    J = reduce(vcat, [src(e), dst(e)] for e in edges(g)) 
    K = ones(Int, 2*ne(g))
    A = sparse(I, J, K)
    FactorGraph(A)
end

function Base.show(io::IO, g::FactorGraph{T}) where T
    nfact = nfactors(g)
    nvar = nvariables(g)
    ned = ne(g)
    println(io, "FactorGraph{$T} with $nfact factors, $nvar variables and $ned edges")
end

nvariables(g::FactorGraph) = nv_right(g.g)
nfactors(g::FactorGraph) = nv_left(g.g)
IndexedGraphs.nv(g::FactorGraph) = nv(g.g)
IndexedGraphs.ne(g::FactorGraph) = ne(g.g)
variables(g::FactorGraph) = 1:nvariables(g)
factors(g::FactorGraph) = 1:nfactors(g)

function IndexedGraphs.inneighbors(g::FactorGraph, a::BipartiteGraphVertex{Factor})
    return @view g.g.A.rowval[nzrange(g.g.X, a.i)]
end
function IndexedGraphs.inneighbors(g::FactorGraph, i::BipartiteGraphVertex{Variable})
    return @view g.g.A.rowval[nzrange(g.g.A, i.i)]
end
IndexedGraphs.outneighbors(g::FactorGraph, v::BipartiteGraphVertex) = inneighbors(g, v)
IndexedGraphs.neighbors(g::FactorGraph, v::BipartiteGraphVertex) = inneighbors(g, v)

function IndexedGraphs.inedges(g::FactorGraph, a::BipartiteGraphVertex{Factor})
    return (IndexedEdge(g.g.X.rowval[k], a.i, g.g.X.nzval[k]) for k in nzrange(g.g.X, a.i))
end
function IndexedGraphs.inedges(g::FactorGraph, i::BipartiteGraphVertex{Variable})
    return (IndexedEdge(g.g.A.rowval[k], i.i, k) for k in nzrange(g.g.A, i.i))
end

function IndexedGraphs.outedges(g::FactorGraph, a::BipartiteGraphVertex{Factor})
    return (IndexedEdge(a.i, g.g.X.rowval[k], g.g.X.nzval[k]) for k in nzrange(g.g.X, a.i))
end
function IndexedGraphs.outedges(g::FactorGraph, i::BipartiteGraphVertex{Variable})
    return (IndexedEdge(i.i, g.g.A.rowval[k], k) for k in nzrange(g.g.A, i.i))
end

"""
    edges(g::FactorGraph)

Return a lazy iterator to the edges of `g`, with the convention that the source is the factor and the destination is the variable
"""
function IndexedGraphs.edges(g::FactorGraph)
    A = g.g.A
    return (IndexedEdge(A.rowval[k], j, k) for j=1:size(A, 2) for k=nzrange(A, j))
end


export FactorGraph, nvariables, nfactors, variables, factors, factor, variable,
    pairwise_interaction_graph,
    inneighbors, outneighbors, neighbors, inedges, outedges, edges, src, dst, idx, ne, nv

end