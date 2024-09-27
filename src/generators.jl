"""
    rand_factor_graph([rng=default_rng()], nvar, nfact, ned)

Create a factor graph with `nvar` variables, `nfact` factors and `ned` edges taken uniformly at random.
"""
function rand_factor_graph(rng::AbstractRNG, nvar::Integer, nfact::Integer, ned::Integer)
    nvar > 0 || throw(ArgumentError("Number of variable nodes must be positive, got $nvar"))
    nfact > 0 || throw(ArgumentError("Number of factor nodes must be positive, got $nfact"))
    ned > 0 || throw(ArgumentError("Number of edges must be positive, got $ned"))
    nedmax = nvar * nfact
    ned ≤ nedmax || throw(ArgumentError("Maximum number of edges is $nvar*$nfact=$nedmax, got $ned"))

    g = rand_bipartite_graph(rng, nfact, nvar, ned)
    return FactorGraph(g)
end
function rand_factor_graph(nvar::Integer, nfact::Integer, ned::Integer)
    rand_factor_graph(default_rng(), nvar, nfact, ned)
end

"""
    rand_factor_graph([rng=default_rng()], nvar, nfact, p)

Create a factor graph with `nvar` variables, `nfact` factors and edges taken independently with probability `p`.
"""
function rand_factor_graph(rng::AbstractRNG, nvar::Integer, nfact::Integer, p::Real)
    nvar > 0 || throw(ArgumentError("Number of variable nodes must be positive, got $nvar"))
    nfact > 0 || throw(ArgumentError("Number of factor nodes must be positive, got $nfact"))
    0 ≤ p ≤ 1 || throw(ArgumentError("Probability must be in [0,1], got $ned"))

    g = rand_bipartite_graph(rng, nfact, nvar, p)
    return FactorGraph(g)
end
function rand_factor_graph(nvar::Integer, nfact::Integer, p::Real)
    rand_factor_graph(default_rng(), nvar, nfact, p)
end

"""
    rand_regular_factor_graph([rng=default_rng()], nvar, nfact, k)

Create a factor graph with `nvar` variables and `nfact` factors, where all factors have degree `k`.
"""
function rand_regular_factor_graph(rng::AbstractRNG, nvar::Integer, nfact::Integer, 
        k::Integer)
    nvar > 0 || throw(ArgumentError("Number of variable nodes must be positive, got $nvar"))
    nfact > 0 || throw(ArgumentError("Number of factor nodes must be positive, got $nfact"))
    k > 0 || throw(ArgumentError("Degree `k` must be positive, got $k"))
    k ≤ nvar || throw(ArgumentError("Degree `k` must be smaller or equal than number of variables, got $k")) 

    g = rand_regular_bipartite_graph(rng, nfact, nvar, k)
    return FactorGraph(g)
end
function rand_regular_factor_graph(nvar::Integer, nfact::Integer, k::Integer)
    rand_regular_factor_graph(default_rng(), nvar, nfact, k)
end

"""
    rand_tree_factor_graph([rng=default_rng()], n)

Create a tree factor graph with `n` vertices in total. The proportion of variables/factors is casual.
"""
function rand_tree_factor_graph(rng::AbstractRNG, n::Integer)
    g = rand_bipartite_tree(rng, n)
    return FactorGraph(g)
end
rand_tree_factor_graph(n::Integer) = rand_tree_factor_graph(default_rng(), n)