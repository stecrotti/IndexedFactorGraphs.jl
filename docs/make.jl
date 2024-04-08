# from https://github.com/JuliaManifolds/Manifolds.jl/blob/71cd2aa54591ee35cdbb45af9c810c5c3704e60c/docs/make.jl#L8
if Base.active_project() != joinpath(@__DIR__, "Project.toml")
    using Pkg
    Pkg.activate(@__DIR__)
    Pkg.develop(PackageSpec(; path=(@__DIR__) * "/../"))
    Pkg.resolve()
    Pkg.instantiate()
end

using FactorGraphs
using Documenter

# for package extension
using Plots, GraphRecipes

DocMeta.setdocmeta!(FactorGraphs, :DocTestSetup, 
    :(using FactorGraphs); recursive=true)

makedocs(;
    modules=[
        FactorGraphs,
        Base.get_extension(FactorGraphs, :FactorGraphsPlotsExt),
    ],
    authors="Stefano Crotti, Alfredo Braunstein, and contributors",
    repo="https://github.com/stecrotti/FactorGraphs.jl/blob/{commit}{path}#{line}",
    sitename="FactorGraphs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://stecrotti.github.io/FactorGraphs.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/stecrotti/FactorGraphs.jl",
    devbranch="main",
    push_preview=true,
)