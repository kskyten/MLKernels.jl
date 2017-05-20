module HyperParameters

import Base: convert, eltype, promote_type, show, string, ==, *, /, +, -, ^, isless

export 
    Bound,
        LeftBound,
        RightBound,
        NullBound,

    Interval,
    interval,
    checkbounds,
    
    HyperParameter,
    getvalue,
    setvalue!,
    checkvalue

include("bound.jl")
include("interval.jl")
include("hyperparameter.jl")

end # End HyperParameter
