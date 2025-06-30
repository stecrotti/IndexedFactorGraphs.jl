const FactorVertex = Left
const VariableVertex = Right

"""
    FactorGraphVertex

A type to represent a vertex in a bipartite graph, to be passed as an argument to [`neighbors`](@ref), [`inedges`](@ref), [`outedges`](@ref), see examples therein.
It is recommended to use the [`v_vertex`](@ref) and [`fvertex`](@ref) constructors.
"""
const FactorGraphVertex = BipartiteGraphVertex

"""
    f_vertex(a::Integer)

Wraps index `a` in a container such that other functions like [`neighbors`](@ref), [`inedges`](@ref), [`outedges`](@ref), knowing that it indices a factor vertex.
"""
f_vertex(a::Integer) = vertex(a, FactorVertex)

"""
    v_vertex(i::Integer)

Wraps index `i` in a container such that other functions like [`neighbors`](@ref), [`inedges`](@ref), [`outedges`](@ref), knowing that it indices a variable vertex.
"""
v_vertex(i::Integer) = vertex(i, VariableVertex)

abstract type AbstractFactorGraph{T} end

# treat an `AbstractFactorGraph`` object as a scalar in broadcasting
Base.broadcastable(b::AbstractFactorGraph) = Ref(b)

"""
    FactorGraph{T}

A type representing a [factor graph](https://en.wikipedia.org/wiki/Factor_graph).
"""
struct FactorGraph{T} <: AbstractFactorGraph{T}
    g :: BipartiteIndexedGraph{T}
end
"""
    FactorGraph(A::AbstractMatrix)

Construct a `FactorGraph` from adjacency matrix `A` with the convention that rows are factors, columns are variables.
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
function pairwise_interaction_graph(g::AbstractGraph)
    N = nv(g)
    E = ne(g)
    I = reduce(vcat, [e, e] for e in 1:E)
    J = reduce(vcat, [src(e), dst(e)] for e in edges(g)) 
    K = ones(Int, 2*ne(g))
    A = sparse(I, J, K, E, N)
    FactorGraph(A)
end

function Base.show(io::IO, g::FactorGraph{T}) where T
    nfact = nfactors(g)
    nvar = nvariables(g)
    ned = ne(g)
    println(io, "FactorGraph{$T} with $nvar variables, $nfact factors, and $ned edges")
end

"""
    nvariables(g::FactorGraph)

Return the number of variables vertices in `g`.
"""
nvariables(g::FactorGraph) = nv_right(g.g)

"""
    nactors(g::FactorGraph)

Return the number of actors vertices in `g`.
"""
nfactors(g::FactorGraph) = nv_left(g.g)

IndexedGraphs.nv(g::FactorGraph) = nv(g.g)
IndexedGraphs.ne(g::FactorGraph) = ne(g.g)

"""
    v_vertices(g::FactorGraph)

Return a lazy iterator to the indices of variable vertices in `g`.
"""
v_vertices(g::FactorGraph) = 1:nvariables(g)

"""
    f_vertices(g::FactorGraph)

Return a lazy iterator to the indices of factor vertices in `g`.
"""
f_vertices(g::FactorGraph) = 1:nfactors(g)

"""
    IndexedGraphs.neighbors(g::FactorGraph, v::FactorGraphVertex)

Return a lazy iterators to the neighbors of vertex `v`.

Examples
========

```jldoctest neighbors
julia> using IndexedFactorGraphs

julia> g = FactorGraph([0 1 1 0;
                        1 0 0 0;
                        0 0 1 1])
FactorGraph{Int64} with 4 variables, 3 factors, and 5 edges

julia> collect(neighbors(g, v_vertex(3)))
2-element Vector{Int64}:
 1
 3

julia> collect(neighbors(g, f_vertex(2)))
1-element Vector{Int64}:
 1
```
"""
function IndexedGraphs.neighbors(g::FactorGraph, a::FactorGraphVertex{FactorVertex})
    return @view g.g.X.rowval[nzrange(g.g.X, a.i)]
end
function IndexedGraphs.neighbors(g::FactorGraph, i::FactorGraphVertex{VariableVertex})
    return @view g.g.A.rowval[nzrange(g.g.A, i.i)]
end


"""
    edge_indices(g::FactorGraph, v::FactorGraphVertex)

Return a lazy iterator to the indices of the edges incident on vertex `v`, with `v`.

The output of `edge_indices` does not allocate and it can be used to index external arrays of properties directly

Examples
========

```jldoctest edge_indices
julia> using IndexedFactorGraphs, Test

julia> g = FactorGraph([0 1 1 0;
                        1 0 0 0;
                        0 0 1 1])
FactorGraph{Int64} with 4 variables, 3 factors, and 5 edges

julia> edgeprops = randn(ne(g));

julia> indices = (idx(e) for e in outedges(g, v_vertex(3)));

julia> indices_noalloc = edge_indices(g, v_vertex(3));

julia> @assert edgeprops[collect(indices)] == edgeprops[indices_noalloc]

julia> @test_throws ArgumentError edgeprops[indices]
Test Passed
      Thrown: ArgumentError
```
"""
function edge_indices(g::FactorGraph, a::FactorGraphVertex{FactorVertex})
    return @view g.g.X.nzval[nzrange(g.g.X, a.i)]
end
function edge_indices(g::FactorGraph, i::FactorGraphVertex{VariableVertex})
    return nzrange(g.g.A, i.i)
end

"""
    edge_indices(g::FactorGraph)

Return a lazy iterator to the indices of the edges in `g`
"""
edge_indices(g::AbstractFactorGraph) = 1:ne(g)


"""
    IndexedGraphs.inedges(g::FactorGraph, v::FactorGraphVertex)

Return a lazy iterators to the edges incident on vertex `v`, with `v` as the destination.

Examples
========

```jldoctest inedges
julia> using IndexedFactorGraphs

julia> g = FactorGraph([0 1 1 0;
                        1 0 0 0;
                        0 0 1 1])
FactorGraph{Int64} with 4 variables, 3 factors, and 5 edges

julia> collect(inedges(g, f_vertex(2)))
1-element Vector{IndexedGraphs.IndexedEdge{Int64}}:
 Indexed Edge 1 => 2 with index 1


julia> collect(inedges(g, v_vertex(3)))
2-element Vector{IndexedGraphs.IndexedEdge{Int64}}:
 Indexed Edge 1 => 3 with index 3
 Indexed Edge 3 => 3 with index 4
```
"""
function IndexedGraphs.inedges(g::FactorGraph, a::FactorGraphVertex{FactorVertex})
    return (IndexedEdge(i, a.i, id) for (i, id) in zip(neighbors(g, a), edge_indices(g, a)))
end
function IndexedGraphs.inedges(g::FactorGraph, i::FactorGraphVertex{VariableVertex})
    return (IndexedEdge(a, i.i, id) for (a, id) in zip(neighbors(g, i), edge_indices(g, i)))

end

"""
    IndexedGraphs.outedges(g::FactorGraph, v::FactorGraphVertex)

Return a lazy iterators to the edges incident on vertex `v`, with `v` as the source.

Examples
========

```jldoctest outedges
julia> using IndexedFactorGraphs

julia> g = FactorGraph([0 1 1 0;
                        1 0 0 0;
                        0 0 1 1])
FactorGraph{Int64} with 4 variables, 3 factors, and 5 edges

julia> collect(outedges(g, f_vertex(2)))
1-element Vector{IndexedGraphs.IndexedEdge{Int64}}:
 Indexed Edge 2 => 1 with index 1

julia> collect(outedges(g, v_vertex(3)))
2-element Vector{IndexedGraphs.IndexedEdge{Int64}}:
 Indexed Edge 3 => 1 with index 3
 Indexed Edge 3 => 3 with index 4
```
"""
function IndexedGraphs.outedges(g::FactorGraph, a::FactorGraphVertex{FactorVertex})
    return (IndexedEdge(a.i, i, id) for (i, id) in zip(neighbors(g, a), edge_indices(g, a)))
end
function IndexedGraphs.outedges(g::FactorGraph, i::FactorGraphVertex{VariableVertex})
    return (IndexedEdge(i.i, a, id) for (a, id) in zip(neighbors(g, i), edge_indices(g, i)))
end


"""
    edges(g::FactorGraph)

Return a lazy iterator to the edges of `g`, with the convention that the source is the factor and the destination is the variable

```jldoctest edges
julia> using IndexedFactorGraphs

julia> g = FactorGraph([0 1 1 0;
                        1 0 0 0;
                        0 0 1 1])
FactorGraph{Int64} with 4 variables, 3 factors, and 5 edges

julia> collect(edges(g))
5-element Vector{IndexedGraphs.IndexedEdge{Int64}}:
 Indexed Edge 2 => 1 with index 1
 Indexed Edge 1 => 2 with index 2
 Indexed Edge 1 => 3 with index 3
 Indexed Edge 3 => 3 with index 4
 Indexed Edge 3 => 4 with index 5
```
"""
function IndexedGraphs.edges(g::FactorGraph)
    A = g.g.A
    return (IndexedEdge(A.rowval[k], j, k) for j=1:size(A, 2) for k=nzrange(A, j))
end

function IndexedGraphs.degree(g::FactorGraph, v::FactorGraphVertex)
    return degree(g.g, linearindex(g.g, v))
end

for method in [:(IndexedGraphs.degree), :(IndexedGraphs.inedges), :(IndexedGraphs.outedges), :(IndexedGraphs.neighbors), :(edge_indices)]
    @eval begin
        function $method(::AbstractFactorGraph, ::Integer)
            return throw(ArgumentError("Properties of a vertex of an `AbstractFactorGraph` such as degree, neighbors, etc. cannot be accessed by an integer. Use a `v_vertex` or `fvertex` wrapper instead.\n"))
        end
    end
end

function IndexedGraphs.adjacency_matrix(g::FactorGraph, T::DataType=Int)
    SparseMatrixCSC(g.g.A.m, g.g.A.n, g.g.A.colptr, g.g.A.rowval, ones(T, nnz(g.g.A)))
end

Graphs.is_cyclic(g::FactorGraph) = is_cyclic(g.g)