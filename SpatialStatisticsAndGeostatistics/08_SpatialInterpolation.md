# Chapter 8 Methods for Spatial Interpolation in Two Dimension

## 8.1 Kriging: an algebraic basis

【主要是对Kriging插值方法的概述，已在[上一章](./07_Geostatistics.md)中介绍过，这里不再介绍】

## 8.2 The EM algorithm

The EM (Expectation Maximization) algorithm, an iterative procedure for computing maximum likelihood estimates when datasets are incomplete, with data values being either MAR(Missing At Random) or MCAR(Missing Completely At Random), is a useful device for calculating the necessary imputations.

简单来说，EM算法的基本思想是：根据己经给出的观测数据，估计出模型参数的值；再依据上一步估计出的参数值估计缺失数据的值，再根据估计出的缺失数据加上之前己经观测到的数据重新再对参数值进行估计，然后反复迭代，直至最后收敛，迭代结束。

ANCOVA，ANalysis of COVAriance

协方差分析的定义：有多个变量同时对因变量产生影响，我们想分析其中的几个对因变量的影响，就需要排除另外变量造成的影响。协方差分析就是把另外的变量作为协变量（covariate，连续变量），其他的作为自变量（independent，分类变量）；把协变量转换成相等的（排除其影响），看自变量对因变量是否还有显著影响。

【以下两小节即是使用EM算法的空间回归和特征向量空间滤波方法，不再介绍，具体在代码中应该有体现】

## 8.3 Spatial autoregression: a spatial EM algorithm

## 8.4 Eigenvector spatial filtering: another spatial EM algorithm
