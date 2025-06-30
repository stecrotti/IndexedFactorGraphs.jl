rng = MersenneTwister(0)
m = 50
n = 100
A = sprand(rng, m, n, 0.1)
g = FactorGraph(A)

@testset "Basics" begin
    @test @inferred nfactors(g) == m
    @test @inferred nvariables(g) == n
    @test all(@inferred degree(g, f_vertex(a)) == length(@inferred neighbors(g,f_vertex(a))) for a in f_vertices(g))
    @test all(@inferred degree(g, v_vertex(i)) == length(@inferred neighbors(g,v_vertex(i))) for i in v_vertices(g))

    @test length(collect(@inferred edges(g))) == @inferred ne(g)

    @test all(all(src(e)==a for (e,a) in zip(inedges(g, v_vertex(i)), neighbors(g, v_vertex(i)))) for i in v_vertices(g))
    @test all(all(src(e)==i for (e,i) in zip(inedges(g, f_vertex(a)), neighbors(g, f_vertex(a)))) for a in f_vertices(g))
    @test all(all(dst(e)==a for (e,a) in zip(outedges(g, v_vertex(i)), neighbors(g, v_vertex(i)))) for i in v_vertices(g))
    @test all(all(dst(e)==i for (e,i) in zip(outedges(g, f_vertex(a)), neighbors(g, f_vertex(a)))) for a in f_vertices(g))

    @test_throws ArgumentError degree(g, 1)
    @test_throws ArgumentError neighbors(g, 1)
    @test_throws ArgumentError inedges(g, 1)
    @test_throws ArgumentError outedges(g, 1)
    @test_throws ArgumentError edge_indices(g, 1)
end    

@testset "Type inference" begin
    test_type_inference(g)
end 

@testset "Broadcasting" begin
    ids = [v_vertex(i) for i in rand(1:nvariables(g), 5)]
    @test degree.(g, ids) == degree.((g,), ids)
end

@testset "Pairwise interactions" begin
    g_pairwise = Graphs.erdos_renyi(n-1, 0.1; seed=0)
    # to test on isolated nodes
    add_vertex!(g_pairwise)
    g_factorgraph = pairwise_interaction_graph(g_pairwise)
    @test all(1:n-1) do i
        neigs_pairwise = neighbors(g_pairwise, i)
        neigs_factorgraph = reduce(vcat, neighbors(g_factorgraph, f_vertex(a)) 
            for a in neighbors(g_factorgraph, v_vertex(i)); init=Int[])
        unique!(neigs_factorgraph)
        filter!(!isequal(i), neigs_factorgraph)
        neigs_pairwise == neigs_factorgraph
    end
end

@testset "Edge indices" begin
    @test all(v_vertices(g)) do i
        idx.(collect(inedges(g, v_vertex(i)))) == edge_indices(g, v_vertex(i))
    end
    @test all(f_vertices(g)) do a
        idx.(collect(inedges(g, f_vertex(a)))) == edge_indices(g, f_vertex(a))
    end
end

@testset "Adjacency matrix" begin
    M = adjacency_matrix(g)
    @test M == ((!=)(0)).(A)
end