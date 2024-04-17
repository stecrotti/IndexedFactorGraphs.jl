kᵢ = 3
kₐ = 4
g = InfiniteRegularFactorGraph(kᵢ, kₐ)

@testset "Basics" begin
    @test degree(g, variable(100)) == kᵢ
    @test degree(g, factor(12)) == kₐ
    @test nfactors(g) == 1
    @test nvariables(g) == 1
    @test ne(g) == 1
    @test variables(g) == 1:1
    @test factors(g) == 1:1
    @test all(edges(g)) do (i, j, id)
        i == 1 && j == 1 && id == 1
    end
end

@testset "Type inference" begin
    test_type_inference(g)
end 

@testset "Edge indices" begin
    @test all(variables(g)) do i
        idx.(collect(inedges(g, variable(i)))) == edge_indices(g, variable(i))
    end
    @test all(factors(g)) do a
        idx.(collect(outedges(g, factor(a)))) == edge_indices(g, factor(a))
    end
end