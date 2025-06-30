kᵢ = 3
kₐ = 4
g = InfiniteRegularFactorGraph(kᵢ, kₐ)

@testset "Basics" begin
    @test degree(g, v_vertex(100)) == kᵢ
    @test degree(g, f_vertex(12)) == kₐ
    @test nfactors(g) == 1
    @test nvariables(g) == 1
    @test ne(g) == 1
    @test v_vertices(g) == 1:1
    @test f_vertices(g) == 1:1
    @test all(edges(g)) do (i, j, id)
        i == 1 && j == 1 && id == 1
    end
end

@testset "Type inference" begin
    test_type_inference(g)
end 

@testset "Edge indices" begin
    @test all(v_vertices(g)) do i
        idx.(collect(inedges(g, v_vertex(i)))) == edge_indices(g, v_vertex(i))
    end
    @test all(f_vertices(g)) do a
        idx.(collect(outedges(g, f_vertex(a)))) == edge_indices(g, f_vertex(a))
    end
end