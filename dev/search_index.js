var documenterSearchIndex = {"docs":
[{"location":"api/","page":"API reference","title":"API reference","text":"CurrentModule = FactorGraphs","category":"page"},{"location":"api/#API-reference","page":"API reference","title":"API reference","text":"","category":"section"},{"location":"api/#Docstrings","page":"API reference","title":"Docstrings","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [FactorGraphs,\n    Base.get_extension(FactorGraphs, :FactorGraphsPlotsExt),\n    ]","category":"page"},{"location":"api/#FactorGraphs.FactorGraph","page":"API reference","title":"FactorGraphs.FactorGraph","text":"FactorGraph{T}\n\nA type representing a factor graph.\n\n\n\n\n\n","category":"type"},{"location":"api/#FactorGraphs.FactorGraph-Tuple{AbstractMatrix}","page":"API reference","title":"FactorGraphs.FactorGraph","text":"FactorGraph(A::AbstractMatrix)\n\nConstruct a FactorGraph from adjacency matrix A with the convention that rows are factors, columns are variables.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.FactorGraphVertex","page":"API reference","title":"FactorGraphs.FactorGraphVertex","text":"FactorGraphVertex\n\nA type to represent a vertex in a bipartite graph, to be passed as an argument to neighbors, inedges, outedges, see examples therein. It is recommended to use the variable and factor constructors.\n\n\n\n\n\n","category":"type"},{"location":"api/#FactorGraphs.InfinteRegularFactorGraph","page":"API reference","title":"FactorGraphs.InfinteRegularFactorGraph","text":"InfinteRegularFactorGraph <: AbstractFactorGraph\n\nA type to represent an infinite regular factor graph with fixed factor and variable degree\n\n\n\n\n\n","category":"type"},{"location":"api/#FactorGraphs.edge_indices-Tuple{FactorGraph, IndexedGraphs.BipartiteGraphVertex{IndexedGraphs.Left}}","page":"API reference","title":"FactorGraphs.edge_indices","text":"IndexedGraphs.edge_indices(g::FactorGraph, v::FactorGraphVertex)\n\nReturn a lazy iterators to the indices of the edges incident on vertex v, with v.\n\nThe output of edge_indices does not allocate and it can be used to index external arrays of properties directly\n\nExamples\n\njulia> using FactorGraphs, Test\n\njulia> g = FactorGraph([0 1 1 0;\n                        1 0 0 0;\n                        0 0 1 1])\nFactorGraph{Int64} with 4 variables, 3 factors, and 5 edges\n\njulia> edgeprops = randn(ne(g));\n\njulia> indices = (idx(e) for e in outedges(g, variable(3)));\n\njulia> indices_noalloc = edge_indices(g, variable(3));\n\njulia> @assert edgeprops[collect(indices)] == edgeprops[indices_noalloc]\n\njulia> @test_throws ArgumentError edgeprops[indices]\nTest Passed\n      Thrown: ArgumentError\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.factor-Tuple{Integer}","page":"API reference","title":"FactorGraphs.factor","text":"factor(a::Integer)\n\nWraps index a in a container such that other functions like neighbors, inedges, outedges, knowing that it indices a factor node.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.factors-Tuple{FactorGraph}","page":"API reference","title":"FactorGraphs.factors","text":"factors(g::FactorGraph)\n\nReturn a lazy iterator to the indices of factor vertices in g.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.nfactors-Tuple{FactorGraph}","page":"API reference","title":"FactorGraphs.nfactors","text":"nactors(g::FactorGraph)\n\nReturn the number of actors vertices in g.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.nvariables-Tuple{FactorGraph}","page":"API reference","title":"FactorGraphs.nvariables","text":"nvariables(g::FactorGraph)\n\nReturn the number of variables vertices in g.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.pairwise_interaction_graph-Tuple{Graphs.AbstractGraph}","page":"API reference","title":"FactorGraphs.pairwise_interaction_graph","text":"pairwise_interaction_graph(g::IndexedGraph)\n\nConstruct a factor graph whose factors are the pair-wise interactions encoded in g.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.rand_factor_graph-Tuple{Random.AbstractRNG, Integer, Integer, Integer}","page":"API reference","title":"FactorGraphs.rand_factor_graph","text":"rand_factor_graph([rng=default_rng()], nvar, nfact, ned)\n\nCreate a factor graph with nvar variables, nfact factors and ned edges taken uniformly at random.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.rand_factor_graph-Tuple{Random.AbstractRNG, Integer, Integer, Real}","page":"API reference","title":"FactorGraphs.rand_factor_graph","text":"rand_factor_graph([rng=default_rng()], nvar, nfact, p)\n\nCreate a factor graph with nvar variables, nfact factors and edges taken independently with probability p.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.rand_regular_factor_graph-Tuple{Random.AbstractRNG, Integer, Integer, Integer}","page":"API reference","title":"FactorGraphs.rand_regular_factor_graph","text":"rand_regular_factor_graph([rng=default_rng()], nvar, nfact, k)\n\nCreate a factor graph with nvar variables and nfact factors, where all factors have degree k.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.rand_tree_factor_graph-Tuple{Random.AbstractRNG, Integer}","page":"API reference","title":"FactorGraphs.rand_tree_factor_graph","text":"rand_tree_factor_graph([rng=default_rng()], n)\n\nCreate a tree factor graph with n vertices in total. The proportion of variables/factors is casual.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.variable-Tuple{Integer}","page":"API reference","title":"FactorGraphs.variable","text":"variable(i::Integer)\n\nWraps index i in a container such that other functions like neighbors, inedges, outedges, knowing that it indices a variable node.\n\n\n\n\n\n","category":"method"},{"location":"api/#FactorGraphs.variables-Tuple{FactorGraph}","page":"API reference","title":"FactorGraphs.variables","text":"variables(g::FactorGraph)\n\nReturn a lazy iterator to the indices of variable vertices in g.\n\n\n\n\n\n","category":"method"},{"location":"api/#Graphs.edges-Tuple{FactorGraph}","page":"API reference","title":"Graphs.edges","text":"edges(g::FactorGraph)\n\nReturn a lazy iterator to the edges of g, with the convention that the source is the factor and the destination is the variable\n\njulia> using FactorGraphs\n\njulia> g = FactorGraph([0 1 1 0;\n                        1 0 0 0;\n                        0 0 1 1])\nFactorGraph{Int64} with 4 variables, 3 factors, and 5 edges\n\njulia> collect(edges(g))\n5-element Vector{IndexedGraphs.IndexedEdge{Int64}}:\n Indexed Edge 2 => 1 with index 1\n Indexed Edge 1 => 2 with index 2\n Indexed Edge 1 => 3 with index 3\n Indexed Edge 3 => 3 with index 4\n Indexed Edge 3 => 4 with index 5\n\n\n\n\n\n","category":"method"},{"location":"api/#Graphs.neighbors-Tuple{FactorGraph, IndexedGraphs.BipartiteGraphVertex{IndexedGraphs.Left}}","page":"API reference","title":"Graphs.neighbors","text":"IndexedGraphs.neighbors(g::FactorGraph, v::FactorGraphVertex)\n\nReturn a lazy iterators to the neighbors of vertex v.\n\nExamples\n\njulia> using FactorGraphs\n\njulia> g = FactorGraph([0 1 1 0;\n                        1 0 0 0;\n                        0 0 1 1])\nFactorGraph{Int64} with 4 variables, 3 factors, and 5 edges\n\njulia> collect(neighbors(g, variable(3)))\n2-element Vector{Int64}:\n 1\n 3\n\njulia> collect(neighbors(g, factor(2)))\n1-element Vector{Int64}:\n 1\n\n\n\n\n\n","category":"method"},{"location":"api/#IndexedGraphs.inedges-Tuple{FactorGraph, IndexedGraphs.BipartiteGraphVertex{IndexedGraphs.Left}}","page":"API reference","title":"IndexedGraphs.inedges","text":"IndexedGraphs.inedges(g::FactorGraph, v::FactorGraphVertex)\n\nReturn a lazy iterators to the edges incident on vertex v, with v as the destination.\n\nExamples\n\njulia> using FactorGraphs\n\njulia> g = FactorGraph([0 1 1 0;\n                        1 0 0 0;\n                        0 0 1 1])\nFactorGraph{Int64} with 4 variables, 3 factors, and 5 edges\n\njulia> collect(inedges(g, factor(2)))\n1-element Vector{IndexedGraphs.IndexedEdge{Int64}}:\n Indexed Edge 1 => 2 with index 1\n\n\njulia> collect(inedges(g, variable(3)))\n2-element Vector{IndexedGraphs.IndexedEdge{Int64}}:\n Indexed Edge 1 => 3 with index 3\n Indexed Edge 3 => 3 with index 4\n\n\n\n\n\n","category":"method"},{"location":"api/#IndexedGraphs.outedges-Tuple{FactorGraph, IndexedGraphs.BipartiteGraphVertex{IndexedGraphs.Left}}","page":"API reference","title":"IndexedGraphs.outedges","text":"IndexedGraphs.outedges(g::FactorGraph, v::FactorGraphVertex)\n\nReturn a lazy iterators to the edges incident on vertex v, with v as the source.\n\nExamples\n\njulia> using FactorGraphs\n\njulia> g = FactorGraph([0 1 1 0;\n                        1 0 0 0;\n                        0 0 1 1])\nFactorGraph{Int64} with 4 variables, 3 factors, and 5 edges\n\njulia> collect(outedges(g, factor(2)))\n1-element Vector{IndexedGraphs.IndexedEdge{Int64}}:\n Indexed Edge 2 => 1 with index 1\n\njulia> collect(outedges(g, variable(3)))\n2-element Vector{IndexedGraphs.IndexedEdge{Int64}}:\n Indexed Edge 3 => 1 with index 3\n Indexed Edge 3 => 3 with index 4\n\n\n\n\n\n","category":"method"},{"location":"api/#RecipesBase.plot-Tuple{FactorGraph}","page":"API reference","title":"RecipesBase.plot","text":"plot(g::FactorGraph; kwargs...)\n\nPlot factor graph g with boxes for factor nodes and circles for variable nodes. It is based on GraphRecipes.graphplot.\n\nOptional arguments\n\nshownames: if set to true, displays the index on every node\noptional arguments to graphplot\n\nExamples\n\njulia> using FactorGraphs\n\njulia> using Plots, GraphRecipes\n\njulia> g = FactorGraph([0 1 1 0;\n                        1 0 1 0;\n                        0 0 1 1])\nFactorGraph{Int64} with 3 factors, 4 variables and 6 edges\n\njulia> plot(g)\n\n\n\n\n\n","category":"method"},{"location":"api/#Index","page":"API reference","title":"Index","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"EditURL = \"https://github.com/stecrotti/FactorGraphs.jl/blob/main/README.md\"","category":"page"},{"location":"#FactorGraphs","page":"Home","title":"FactorGraphs","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"(Image: ) (Image: Build Status) (Image: codecov)","category":"page"},{"location":"","page":"Home","title":"Home","text":"A Julia package to work with factor graphs.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"julia> import Pkg; Pkg.add(url=\"https://github.com/stecrotti/FactorGraphs.jl\")","category":"page"},{"location":"#Basics","page":"Home","title":"Basics","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A factor graph is a set of variable and factor vertices connected by edges.  In the spirit of IndexedGraphs.jl, here each edge comes with an index, which can be used to access edge properties (e.g. messages in a message-passing algorithm).","category":"page"},{"location":"#Graph-construction","page":"Home","title":"Graph construction","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A FactorGraph can be constructed starting from an adjacency matrix, with the convention that rows represent factor vertices and columns represent variable vertices","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> using FactorGraphs\n\njulia> g = FactorGraph([0 1 1 0;\n                        1 0 0 0;\n                        0 0 1 1])\nFactorGraph{Int64} with 4 variables, 3 factors, and 5 edges","category":"page"},{"location":"","page":"Home","title":"Home","text":"Alternatively, use one of the provided generators for random factor graphs","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> g_rand = rand_factor_graph(5, 3, 6)\nFactorGraph{Int64} with 5 variables, 3 factors, and 6 edges","category":"page"},{"location":"#Graph-navigation","page":"Home","title":"Graph navigation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Given a factor graph with N variables and M factors, variables are indexed by iin1ldotsN, factors are indexed by ain1ldotsM. Properties of a vertex can be queried by wrapping the vertex index in a variable or factor. For example, the list of neighbors of variable i=2 is found by","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> ∂i = neighbors(g, variable(2));\n\njulia> collect(∂i)\n2-element Vector{Int64}:\n 1\n 3","category":"page"},{"location":"","page":"Home","title":"Home","text":"where 13 are to be interpreted as indices of factor vertices.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The list of edges adjacent to factor a=1 is found by","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> ea = inedges(g, factor(1));\n\njulia> collect(ea)\n3-element Vector{IndexedGraphs.IndexedEdge{Int64}}:\n Indexed Edge 1 => 1 with index 1\n Indexed Edge 2 => 1 with index 2\n Indexed Edge 5 => 1 with index 6","category":"page"},{"location":"","page":"Home","title":"Home","text":"Querying properties of a vertex without specifying whether it's a variable or a factor will throw an error","category":"page"},{"location":"","page":"Home","title":"Home","text":"julia> outedges(g, 3)\nERROR: ArgumentError: Properties of a vertex of an `AbstractFactorGraph` such as degree, neighbors, etc. cannot be accessed by an integer. Use a `variable` or `factor` wrapper instead.","category":"page"}]
}