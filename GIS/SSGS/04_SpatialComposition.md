# Chapter 4 Spatial Composition and configuration

## 4.1 Spatial heterogeneity: mean and variance

Often power transformations can stabilize variability in variance across a geographic landscape. For example,

+ $$Y^*=(Y+\delta)^{\lambda}, \lambda≠0$$
+ $$Y^*=ln(Y+\delta), \lambda=0$$
+ $$Y^*=e^{-{\lambda}Y}$$

这个变换过程就是Box-Cox变换，即Box和Cox在1964年提出的一种广义幂变换方法，是统计建模中常用的一种数据变换，用于连续的响应变量不满足正态分布的情况。Box-Cox变换之后，可以一定程度上减小不可观测的误差和预测变量的相关性。Box-Cox变换的主要特点是引入一个参数，通过数据本身估计该参数进而确定应采取的数据变换形式，Box-Cox变换可以明显地改善数据的正态性、对称性和方差相等性，对许多实际数据都是行之有效的。

### 4.1.1 ANOVA

ANalysis Of VAriance is a classical technique that accounts for difference of means across groups when the variance is homogeneous. An accompanying assumption is that data conform to a bell-shaped curve within each group.

ANOVA furnishes the tool needed for a quantitative evaluation of pairwise and simultaneous differences between a regional means.

这里介绍的比较简略，再补充一些。

ANOVA分析的目的是检验每个组的均值是否相同，零假设（null hypothesis）是$$H_0:\mu_1=\mu_2=...=\mu_n$$。使用ANOVA分析方法的前提是：

+ 方差是同质的（homogeneous），即每组样品背后的总体（population，也称族群）有着相同的方差，也称方差相等、方差齐次；
+ 总体正态分布
+ 抽样是独立的

（各种性质的检验方法见4.1.4）

ANOVA中的一些重要概念：

+ 组间均方（mean squared between, MSB），相当于每个分布相对于总体的方差，即在H0为真的前提下，由均值抽样平均误差计算得到，这样得到的方差包含两部分的变动：一是各个水平内部的随机性变动，二是各个水平之间的变动；
+ 组内均方（mean squared error, MSE），也就是每个分布自身的方差的平均值，用各个样本方差估计得到的，只与每个样本内部的方差有关，反映各个水平内部随机性的变动；
+ F统计量（F-Statistics），其服从于F分布，$$F=\frac{MSB}{MSE}$$。

单因素ANOVA步骤：

1. 建立零假设和备择假设

    $$H_0: \mu_1=\mu_2=...=\mu_c$$

    $$H_1: \mu_1、\mu_2...\mu_c$$不全相等

2. 计算各组样本的均值和样本方差

    $$\overline{x_j}=\frac{\sum_{i=1}^{n_j}{x_{ij}}}{n_j}$$

    $$s_j^2=\frac{\sum_{i=1}^{n_j}{(x_{ij}-\overline{x_j})^2}}{n_j-1}$$

3. 计算组间方差MSB

    $$\overline{x}=\frac{\sum_{j=1}^{c}\sum_{i=1}^{n_j}{x_{ij}}}{\sum_{j=1}^{c}{n_j}}$$

    $$MSB=\frac{\sum_{j=1}^c{n_j(\overline{x_j}-\overline{x})^2}}{c-1}$$

    记$$\sum_{j=1}^{c}{n_j}=n_T$$

4. 计算组内方差MSE

    $$MSE=\frac{\sum_{j=1}^{c}{s_j^2}}{n_T-c}$$

5. 构造F检验量

    $$F=\frac{MSB}{MSE}$$~$$F(c-1,n_T-c)$$

    当F值很大时，则可以拒绝原假设。若给定显著性水平$$\alpha$$，则拒绝域为$$F>F_{\alpha}(c-1,n_T-c)$$

以下两小节内容即从区域和方向两个角度检验了某数据样本各组均值的一致性。

### 4.1.2 Testing for heterogeneity over a plane: regional supra-partitionings

### 4.1.3 Testing for heterogeneity over a plane: directional supra-partitionings

### 4.1.4 Covariates across a geographic landscape

本节主要介绍了灌溉区农场的数量（IRRF）和平均降水量之间进行回归分析的一个过程。涉及到的一些统计过程如下：

1. 因为IRRF依赖于区域大小，所以对IRRF进行了Box-Cox变换，$$ln(\frac{IRRF}{area}+0.04)$$
2. 对IRRF进行正态性诊断检验，常见的正态性参数检验方法有偏度-峰度检验、K-S检验（D检验）、Lilliefor检验、S-W检验（只适用于小样本），常见的非参数检验方法有茎叶图、直方图、QQ图、PP图等
3. 线性回归
4. 方差齐次检验，常用方法有：Hartley检验（仅适用于样本量相等的场合）、Bartlett检验（可用于样本量相等或不等的场合，但是每个样本量不得低于5）、修正的Bartlett检验（在样本量较小或较大，相等或不等的场合均可使用）、Levene检验（Levene检验是将每个值先转换为为该值与其组内均值的偏离程度，然后再用转换后的偏离程度去做方差分析，即组间方差/组内方差）。
5. PRESS统计量，Prediction Error Sum of Squares，即使用交叉验证方法得到的MSE
6. 分组进行ANOVA
7. 结论是降雨量解释了IRRF的区域差异

## 4.2 Spatial weight matrices

3 popular spatial weight matrices：

+ **C**：it is topologically based and constructed as a $$n*n$$ table of binary 0-1 indicator variables, one for each location on a map. 也就是最基本的基于拓扑关系的权重矩阵，在第二章中就是使用这个矩阵计算MC和GR的，对于点数据和线数据来说，可以通过Voronoi图来反映要素间的邻接关系
+ **W**：row standardized matrix **C**, the element $$w_{ij}=\frac{c_{ij}}{\sum{j=1}{n}{c{ij}}}$$, or in matrix notation $$\bold{W}=\left[
    \begin{matrix}
    \bold{1}^T\bold{c_1} & \cdots  &0 \\
    \vdots & \ddots & \cdots \\
    0 & \cdots & \bold{1}^T\bold{c_n}
    \end{matrix}\right]^{-1}\bold{C}$$
where $$\bold{1}$$ is an $$n*1$$ vector of ones, $$\bold{c_j}$$ is the $$j$$ th row vector of **C**.

    W即是行标准化后的矩阵C，该矩阵也可以用于计算MC和GR，在空间统计中很常见。

+ **MCM**=$$(\bold{I}-\bold{1}\bold{1}^T/n)\bold{C}(\bold{I}-\bold{1}\bold{1}^T/n)$$

    The pre- and post-multiplying matrix is one version of a projection matrix found throught linear statistical theory. Here it causes the first eigenfunction of C to be replaced with a constant vector (i.e., proportional to vector 1) and accompanying eigenvalue of 0, while asymptotically preserving the remaining n – 1 eigenfunctions.

Besides, spatial weights can also be based upon distance. Here are 3 common formulation:

+ if two locations are nearest neighbors, then $$c_{ij}=1$$; otherwise $$c_{ij}=0$$
+ $$c_{ij}=1$$ if the distance less than a threshold; otherwise, $$c_{ij}=0$$
+ use the power of diverse distance, then row standardized into **W** matrix

## 4.3 Spatial heterogeneity: spatial autocorrelation

two ways to analysis spatial heterogeneity:

+ regional difference: spatial autocorrelation, includes MC, GR, etc.
+ directional difference: lattice structures model,  semi-variogram model.
