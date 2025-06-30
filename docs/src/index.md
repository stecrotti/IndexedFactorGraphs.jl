```@meta
EditURL = "https://github.com/stecrotti/IndexedFactorGraphs.jl/blob/main/README.md"
```

# IndexedFactorGraphs

[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://stecrotti.github.io/IndexedFactorGraphs.jl/dev)
[![Build Status](https://github.com/stecrotti/IndexedFactorGraphs.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/stecrotti/IndexedFactorGraphs.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![codecov](https://codecov.io/gh/stecrotti/IndexedFactorGraphs.jl/graph/badge.svg?token=nGaGg7oJom)](https://codecov.io/gh/stecrotti/IndexedFactorGraphs.jl)

A Julia package to work with [factor graphs](https://en.wikipedia.org/wiki/Factor_graph).

## Installation
```julia
julia> import Pkg; Pkg.add(url="https://github.com/stecrotti/IndexedFactorGraphs.jl")
```

## Basics
A factor graph is a set of variable and factor vertices connected by edges. 
In the spirit of [IndexedGraphs.jl](https://github.com/stecrotti/IndexedGraphs.jl), here each edge comes with an index, which can be used to access edge properties (e.g. messages in a message-passing algorithm).

### Graph construction
A `FactorGraph` can be constructed starting from an adjacency matrix, with the convention that rows represent factor vertices and columns represent variable vertices
```julia
julia> using IndexedFactorGraphs

julia> g = FactorGraph([0 1 1 0;
                        1 0 0 0;
                        0 0 1 1])
FactorGraph{Int64} with 4 variables, 3 factors, and 5 edges
```

Alternatively, use one of the provided generators for random factor graphs
```julia
julia> g_rand = rand_factor_graph(5, 3, 6)
FactorGraph{Int64} with 5 variables, 3 factors, and 6 edges
```

### Graph navigation 
Given a factor graph with $N$ variables and $M$ factors, variables are indexed by $i\in\{1,\ldots,N\}$, factors are indexed by $a\in\{1,\ldots,M\}$.
Properties of a vertex can be queried by wrapping the vertex index in a `v_vertex` or `f_vertex`. For example, the list of neighbors of variable $i=2$ is found by
```julia
julia> ∂i = neighbors(g, v_vertex(2));

julia> collect(∂i)
2-element Vector{Int64}:
 1
 3
```
where $1,3$ are to be interpreted as indices of factor vertices.

The list of edges adjacent to factor $a=1$ is found by
```julia
julia> ea = inedges(g, f_vertex(1));

julia> collect(ea)
3-element Vector{IndexedGraphs.IndexedEdge{Int64}}:
 Indexed Edge 1 => 1 with index 1
 Indexed Edge 2 => 1 with index 2
 Indexed Edge 5 => 1 with index 6
```

Querying properties of a vertex without specifying whether it's a variable or a factor will throw an error
```julia
julia> outedges(g, 3)
ERROR: ArgumentError: Properties of a vertex of an `AbstractFactorGraph` such as degree, neighbors, etc. cannot be accessed by an integer. Use a `v_vertex` or `f_vertex` wrapper instead.
```

## See also
For less lightweight implementations, also including message-passing algorithms, check out
* [FactorGraph.jl](https://github.com/mcosovic/FactorGraph.jl)
* [ForneyLab.jl](https://github.com/biaslab/ForneyLab.jl)
