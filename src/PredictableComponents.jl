module PredictableComponents

using CoupledFields
export InputSpace, ModelObj
 export AIF, CVfn, KCCA, gKYA, predict
 export G, parzen


"""
    AIF(G::Matrix, X::Vector, Y::Vector, τ::Int) \n
Auto-Information Function  

"""
function AIF(G::Matrix{Float64}, X::T, Y::T, τ::Int) where T<:Vector{Float64}
    n = size(G,1)-τ
    Gx = G[1:n,1:n]
    Ya = Y[(1+τ):end,:]

# Gx needs to be centered so that cor(Uₓ) = Iₚ    
    N = fill(1/n, n, n)
    Gx += -N*Gx + Gx*-N + N*Gx*N 
    ev, Ux = eig(Symmetric(Gx)) 
    l = cumsum(flipdim(ev,1))/sum(ev)
    d = sum(l.≤0.99)
    j = n:-1:(n-d+1) 
    U = Ux[:,j]
    yhat = U * (U'U \ U'Ya)
    imin = indmin(X[1:n])
    imax = indmax(X[1:n])
    return sign(yhat[imax]-yhat[imin])*cor(Ya, yhat)[1]
end

"""
    CVfn(parm::Matrix, X::Matrix, Y::Matrix, modelfn::Function)  \n
Cross-validation function 
"""
function CVfn(parm::T, X::T, Y::T, modelfn::Function) where T<:Matrix{Float64}
    
    # CV metric parameters?
    # par[3] = τ lags
    
    # Model parameters
    # par[1] = Kernel parameter
    # par[2] = no. of PCs

    local n::Int64
    local p::Int64
    local τ::Int64
    nrg = size(parm, 1)
    n, p = size(X) 
    # Setup
    ta = 1:floor(Int, n/2)
    tb = setdiff(1:n,ta)

    xm1 = mean(X[ta,:],1);     ym1 = mean(Y[ta,:],1)

    
    X1train = X[ta,:].-xm1;  Y1train = Y[ta,:].-ym1  
    X1test = X[tb,:].-xm1;  Y1test = Y[tb,:].-ym1 

    lags = [1:floor(Int, n/8);]
    
    Rsq = zeros(nrg)
    for i in 1:nrg
        percent = round(100*i/nrg)
        @printf " %03d%%" percent
        par = parm[i,:]
        τ = par[3]
        model1 = modelfn(par, X1train, Y1train, lags)
        W1 = model1.W[:,1:1]; A1 = model1.A[:,1:1] 
        Rcv = X1test[:, 1:Int(par[2])]*W1
        Tcv = Y1test[:, 1:Int(par[2])]*A1
        Gr = G(Rcv)
        Rsq[i] = KCCA(Gr, Tcv, Int(par[3]))[1]
        println([parm[i:i,:] Rsq[i] ])
    end
    parm = [parm Rsq]
#    println(parm)
    imax = indmax(parm[:,end])
    return parm[imax,:]
end

"""
    G(X::Matrix) \n
Gram matrix of `X`
"""
function G(X::T) where T<:Matrix{Float64}
    kpars = GaussianKP(X)
    G = CoupledFields.Kf([1.0], X, kpars)
    return G
end

"""
    gKPrC(par::Vector, X::Matrix, Y::Matrix, lags::Vector{Int})  \n
gradient Kernel Predictable Components Analysis \n 
The vector `par` has 3 elements: `par[1]=σ`, `par[2]=` the number of components to keep, and \n 
`par[3]=τ` the lead time to calculate `A` the projection vector of `Y`. 
"""
function gKPrC(par::Vector{Float64}, X::T, Y::T, lags::Vector{Int}) where T<:Matrix{Float64}
    local n::Int64
    local p::Int64
#    local lagmax::Int64
    Zx = X[:,1:Int(par[2])]
    Zy = Y[:,1:Int(par[2])]
    n, p = size(Zx)
    kpars = GaussianKP(Zx)
    ∇K = CoupledFields.∇Kf(par, Zx, kpars)
    Gx = CoupledFields.Kf(par, Zx, kpars)
    M = zeros(p,p)
    for τ in lags
        nr = n-τ
        H = Gx[1:nr,1:nr] \ Zy[(τ+1):n,:]
        F = H*H'
        Mi = zeros(p,p)
        for i in 1:nr
            dK = ∇K[i,1:nr,:]
            Mi += dK'*F*dK
        end
       M += Mi./nr
    end
    ev = eigfact(Symmetric(M))
    W = flipdim(ev.vectors, 2)
    Rx = Zx * W
    Gr = G(Rx[:,1:1])
    sv, A = KCCA(Gr, Zy, Int(par[3]))
    Ry = Zy * A
    return ModelObj(W, Rx, A, Ry, flipdim(ev.values,1), par, "gKPrC")
end


"""
    KCCA(G::Matrix, Y::Matrix, τ::Int)  \n
Kernel Canonical Correlation Analysis  \n
Calculates the projection vector of `Y`
"""
function KCCA(G::T, Y::T, τ::Int) where T<:Matrix{Float64}
    n = size(G,1)-τ
    Gx = G[1:n,1:n]
    Ya = Y[(1+τ):end,:]

# Gx needs to be centered so that cor(Uₓ) = Iₚ    
    N = fill(1/n, n, n)
    Gx += -N*Gx + Gx*-N + N*Gx*N 
    ev, Ux = eig(Symmetric(Gx)) 
    l = cumsum(flipdim(ev,1))/sum(ev)
    d = sum(l.≤0.99)
    j = n:-1:(n-d+1) 
    M = cor(Ux[:,j],Ya)
    U,_,V = svd(M)
    sv = cor(Ux[:,j]*U[:,1], Ya*V[:,1])
    return sv^2, V
end

"""
    gKYA(model::ModelObj, Y::Matrix, dcca::Int) \n

"""
function gKYA(model::ModelObj, Y::Matrix{Float64}, dcca::Int) 
    par = model.pars
    Zy = Y[:,1:Int(par[2])]
    A = zeros(Int(par[2]) ,dcca)
    for j in 1:dcca
        Gr = G(model.R[:,j:j])
        A[:,j] = KCCA(Gr, Zy, 0)[2][:,1]
    end
    T = Zy * A 
    return ModelObj(model.W, model.R, A, T, model.evals, par, "gKPrC")
end


# kcr
"""
    predict(X::Vector, Y::Vector, τ::Int) \n

"""
function predict(X::T, Y::T, τ::Int) where T<:Vector{Float64}
    Gx = G(X[1:(end-τ),1:1])
    n = size(Gx,1)
    Ya = Y[(1+τ):end,:]
    
    # Gx needs to be centered so that cor(Uₓ) = Iₚ    
    N = fill(1/n, n, n)
    Gx += -N*Gx + Gx*-N + N*Gx*N 
    ev, Ux = eig(Symmetric(Gx)) 
    l = cumsum(flipdim(ev,1))/sum(ev)
    d = sum(l.≤0.99)
    j = n:-1:(n-d+1) 
    U = Ux[:,j]
    yhat = U * (U'U \ U'Ya)
    return yhat[:]
end


"""
    parzen(tau::Vector{Int}, M::Int)
Parzen filter.
"""
function parzen(tau::Vector{Int}, M::Int)
    τ = abs.(tau)
    i = τ .>= M/2   
    z =   (i).*(2(1-τ/M).^3) +  (.!i).*(1-6(τ/M).^2 + 6(τ/M).^3)        
    z *= 1.0/sum(z)
    return z
end





end # module
