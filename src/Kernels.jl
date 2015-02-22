#===================================================================================================
  Kernel Functions Module
===================================================================================================#

module Kernels

import Base: show

export
    # Types
    MercerKernel,
    ScaledMercerKernel,
    #CompositeMercerKernel,
    #ProductMercerKernel,
    # Functions
    kernelfunction,
    arguments,
    description,
	# Mercer Kernels
    PointwiseProductKernel,
	MercerKernel,
	LinearKernel,
	PolynomialKernel,
	GaussianKernel,
	LaplacianKernel,
	SigmoidKernel,
	RationalQuadraticKernel,
	MultiQuadraticKernel,
	InverseMultiQuadraticKernel,
	PowerKernel,
	LogKernel,
	SplineKernel
	
	# Kernel Matrix Functions
	#center_kernelmatrix!,
	#center_kernelmatrix,
	#kernelmatrix

include("MercerKernels.jl")
#include("Gramian.jl")

end # Kernels
