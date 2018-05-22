var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#PredictableComponents.jl-1",
    "page": "Home",
    "title": "PredictableComponents.jl",
    "category": "section",
    "text": ""
},

{
    "location": "#Introduction-1",
    "page": "Home",
    "title": "Introduction",
    "category": "section",
    "text": ""
},

{
    "location": "#Linear-Predictability-1",
    "page": "Home",
    "title": "Linear Predictability",
    "category": "section",
    "text": "iota_Pr=fracWleft(sum_tau=1^infty Sigma_YXSigma_X^-1Sigma_XY right) WW Sigma_XW"
},

{
    "location": "#Nonlinear-Predictability-1",
    "page": "Home",
    "title": "Nonlinear Predictability",
    "category": "section",
    "text": "..."
},

{
    "location": "#Guide-1",
    "page": "Home",
    "title": "Guide",
    "category": "section",
    "text": "Pages = joinpath.(\"man\", [\"Example 1.md\",\"Example 2.md\"])\nDepth = 1"
},

{
    "location": "#Library-1",
    "page": "Home",
    "title": "Library",
    "category": "section",
    "text": "Pages = [joinpath(\"lib\",\"library.md\")]"
},

{
    "location": "#Documentation-1",
    "page": "Home",
    "title": "Documentation",
    "category": "section",
    "text": "The documentation was built using Documenter.jl.println(\"Documentation built $(now()) with Julia $(VERSION).\") # hide"
},

{
    "location": "man/Example 1/#",
    "page": "Example 1",
    "title": "Example 1",
    "category": "page",
    "text": ""
},

{
    "location": "man/Example 1/#Example-1-1",
    "page": "Example 1",
    "title": "Example 1",
    "category": "section",
    "text": ""
},

{
    "location": "man/Example 2/#",
    "page": "Example 2",
    "title": "Example 2",
    "category": "page",
    "text": ""
},

{
    "location": "man/Example 2/#Example-2-1",
    "page": "Example 2",
    "title": "Example 2",
    "category": "section",
    "text": ""
},

{
    "location": "lib/library/#",
    "page": "Library",
    "title": "Library",
    "category": "page",
    "text": ""
},

{
    "location": "lib/library/#Library-1",
    "page": "Library",
    "title": "Library",
    "category": "section",
    "text": "Pages = [\"library.md\"]"
},

{
    "location": "lib/library/#CoupledFields.ModelObj",
    "page": "Library",
    "title": "CoupledFields.ModelObj",
    "category": "type",
    "text": "ModelObj: A type to hold statistical model results\n\nSuch as the matrices W, R, A, T, where R=XW and T=YA.  \n\n\n\n"
},

{
    "location": "lib/library/#Types-1",
    "page": "Library",
    "title": "Types",
    "category": "section",
    "text": "ModelObj"
},

{
    "location": "lib/library/#PredictableComponents.AIF-Union{Tuple{Array{Float64,2},T,T,Int64}, Tuple{T}} where T<:Array{Float64,1}",
    "page": "Library",
    "title": "PredictableComponents.AIF",
    "category": "method",
    "text": "AIF(G::Matrix, X::Vector, Y::Vector, τ::Int)\n\nAuto-Information Function  \n\n\n\n"
},

{
    "location": "lib/library/#PredictableComponents.CVfn-Union{Tuple{T,T,T,Function}, Tuple{T}} where T<:Array{Float64,2}",
    "page": "Library",
    "title": "PredictableComponents.CVfn",
    "category": "method",
    "text": "CVfn(parm::Matrix, X::Matrix, Y::Matrix, modelfn::Function)\n\nCross-validation function \n\n\n\n"
},

{
    "location": "lib/library/#PredictableComponents.G-Union{Tuple{T}, Tuple{T}} where T<:Array{Float64,2}",
    "page": "Library",
    "title": "PredictableComponents.G",
    "category": "method",
    "text": "G(X::Matrix)\n\nGram matrix of X\n\n\n\n"
},

{
    "location": "lib/library/#PredictableComponents.KCCA-Union{Tuple{T,T,Int64}, Tuple{T}} where T<:Array{Float64,2}",
    "page": "Library",
    "title": "PredictableComponents.KCCA",
    "category": "method",
    "text": "KCCA(G::Matrix, Y::Matrix, τ::Int)\n\nKernel Canonical Correlation Analysis  \n\nCalculates the projection vector of Y\n\n\n\n"
},

{
    "location": "lib/library/#PredictableComponents.gKYA-Tuple{CoupledFields.ModelObj,Array{Float64,2},Int64}",
    "page": "Library",
    "title": "PredictableComponents.gKYA",
    "category": "method",
    "text": "gKYA(model::ModelObj, Y::Matrix, dcca::Int)\n\n\n\n"
},

{
    "location": "lib/library/#PredictableComponents.parzen-Tuple{Array{Int64,1},Int64}",
    "page": "Library",
    "title": "PredictableComponents.parzen",
    "category": "method",
    "text": "parzen(tau::Vector{Int}, M::Int)\n\nParzen filter.\n\n\n\n"
},

{
    "location": "lib/library/#PredictableComponents.predict-Union{Tuple{T,T,Int64}, Tuple{T}} where T<:Array{Float64,1}",
    "page": "Library",
    "title": "PredictableComponents.predict",
    "category": "method",
    "text": "predict(X::Vector, Y::Vector, τ::Int)\n\n\n\n"
},

{
    "location": "lib/library/#PredictableComponents.gKPrC-Union{Tuple{Array{Float64,1},T,T,Array{Int64,1}}, Tuple{T}} where T<:Array{Float64,2}",
    "page": "Library",
    "title": "PredictableComponents.gKPrC",
    "category": "method",
    "text": "gKPrC(par::Vector, X::Matrix, Y::Matrix, lags::Vector{Int})\n\ngradient Kernel Predictable Components Analysis \n\nThe vector par has 3 elements: par[1]=σ, par[2]= the number of components to keep, and \n\npar[3]=τ the lead time to calculate A the projection vector of Y. \n\n\n\n"
},

{
    "location": "lib/library/#Functions-1",
    "page": "Library",
    "title": "Functions",
    "category": "section",
    "text": "Modules = [PredictableComponents]\nOrder   = [:function]"
},

]}
