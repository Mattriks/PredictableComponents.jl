using Documenter, PredictableComponents

makedocs(
    modules = [CoupledFields,PredictableComponents],
    clean = false,
    format = :html,
    sitename = "Predictable\nComponents.jl",
    pages = [
        "Home" => "index.md",
        "Guide" => Any["man/Example 1.md","man/Example 2.md"],
        "Library" => "lib/library.md"
    ],
    # Use clean URLs, unless built as a "local" build
    html_prettyurls = !("local" in ARGS),
#    html_canonical = "https://juliadocs.github.io/Documenter.jl/stable/",
)

deploydocs(
    repo = "github.com/Mattriks/PredictableComponents.jl.git",
    target = "build",
    julia = "0.6",
    osname = "linux",
    deps = nothing,
    make = nothing,
)

