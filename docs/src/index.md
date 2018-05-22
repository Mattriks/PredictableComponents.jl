
# PredictableComponents.jl


## Introduction

### Linear Predictability


```math
\iota_{Pr}=\frac{W'\left(\sum_{\tau=1}^\infty \Sigma_{YX}\Sigma_{X}^{-1}\Sigma_{XY} \right) W}{W' \Sigma_{X}W}
```

### Nonlinear Predictability

...

## Guide

```@contents
Pages = joinpath.("man", ["Example 1.md","Example 2.md"])
Depth = 1
```

## Library

```@contents
Pages = [joinpath("lib","library.md")]
```


## Documentation

The documentation was built using [Documenter.jl](https://github.com/JuliaDocs).

```@example
println("Documentation built $(now()) with Julia $(VERSION).") # hide
```


