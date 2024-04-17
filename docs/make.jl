# from https://github.com/JuliaManifolds/Manifolds.jl/blob/71cd2aa54591ee35cdbb45af9c810c5c3704e60c/docs/make.jl#L8
if Base.active_project() != joinpath(@__DIR__, "Project.toml")
    using Pkg
    Pkg.activate(@__DIR__)
    Pkg.develop(PackageSpec(; path=(@__DIR__) * "/../"))
    Pkg.resolve()
    Pkg.instantiate()
end

using IndexedFactorGraphs
using Documenter

# for package extension
using Plots, GraphRecipes

DocMeta.setdocmeta!(IndexedFactorGraphs, :DocTestSetup, 
    :(using IndexedFactorGraphs); recursive=true)


# Copy README
# copied from https://github.com/rafaqz/Interfaces.jl/blob/071d44f6ae9c5a1c0e53b4a06cc44598224fbcc7/docs/make.jl#L8-L25
base_url = "https://github.com/stecrotti/IndexedFactorGraphs.jl/blob/main/"
index_path = joinpath(@__DIR__, "src", "index.md")
readme_path = joinpath(dirname(@__DIR__), "README.md")

open(index_path, "w") do io
    println(
        io,
        """
        ```@meta
        EditURL = "$(base_url)README.md"
        ```
        """,
    )
    for line in eachline(readme_path)
        println(io, line)
    end
end

makedocs(;
    modules=[
        IndexedFactorGraphs,
        Base.get_extension(IndexedFactorGraphs, :IndexedFactorGraphsPlotsExt),
    ],
    authors="Stefano Crotti, Alfredo Braunstein, and contributors",
    repo="https://github.com/stecrotti/IndexedFactorGraphs.jl/blob/{commit}{path}#{line}",
    sitename="IndexedFactorGraphs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://stecrotti.github.io/IndexedFactorGraphs.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API reference" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/stecrotti/IndexedFactorGraphs.jl",
    devbranch="main",
    push_preview=true,
)