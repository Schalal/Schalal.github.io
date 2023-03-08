# Chapter 5 Spatially Adjusted Regression and Related Spatial Econometrics

Classical statistics attaches a probability distribution to the residuals of prediction equation. Spatial statistics modifies this situation by specifying a prediction function that has $Y$ on both sides of the equation, which means that a value at location $i$ is at least partially a function of the values of $Y$ at nearby locations. This conceptualization captures the essence of spatial autocorrelation.

## 5.1 Linear regression

SAR, simultaneous autoregression:

$Y=\rho\pmb{W}Y+(\pmb{I}-\rho\pmb{W})\pmb{X}\pmb{\beta}+\pmb{\epsilon}$

where:

+ $\pmb{W}$ is the row standardized spatial weight matrix, also called row standardized geographic connectivity matrix;
+ $\pmb{I}$ is an $n*n$ identity matrix;
+ $\rho$ is the spatial autocorrelation parameter;
+ $\pmb{\beta}$ is a $(P+1)*1$ vector of regression coefficients (including the intercept term);
+ $\pmb{\epsilon}$ is an $n*1$ vector of iid $N(0,\sigma^2)$, which can be written in matrix form as the multivariate normal distribution $MVN(\pmb{0},\pmb{I}\sigma^2)$

If considering $\epsilon$ in the standard linear regression model $Y=\pmb{X}\pmb{\beta}+\epsilon$ is spatial auto-related, then the model can be written as $Y=\pmb{X}\pmb{\beta}+(\pmb{I}-\rho\pmb{W})^{-1}\epsilon$, and the spatial regression equation can be written as:

$Y=\pmb{X}\pmb{\beta}+[\rho\pmb{W}(Y-\pmb{X}\pmb{\beta})+\pmb{\epsilon}]=\pmb{X}\pmb{\beta}+\xi$

然后本节内容就是对回归方程的近似估计（使用权重阵的特征值）和应用场景了。以下是根据《空间数据分析》一书的补充内容（虽然二者对空间回归方程的一般形式的定义有区别但本质上都是一致的）。

Anselin给出的空间回归的一般形式：

$Y=\rho{W_1}Y+X\beta+u, u=\lambda{W_2}\epsilon+\mu, \mu$~$N[0,\sigma^2I]$

其中:

+ $Y$为因变量
+ $x$为解释变量
+ $\beta$为解释变量的回归系数
+ $u$为随空间变化的误差项
+ $\mu$为噪声
+ $W_1$为反映因变量自身空间趋势的空间权重矩阵
+ $W_2$为反映残差空间趋势的空间权重矩阵，可以与$W_1$一致
+ $\rho$为空间滞后项（行标准化后的空间权重阵）的系数，值在0到1之间，越接近1表示相邻地区的因变量取值越相似
+ $\lambda$为空间误差参数，值在0到1之间，越接近1表示相邻地区的解释变量取值越相似

|情形|模型名|说明|
|:----:|:----:|:----:|
|$\rho=0,\lambda=0$|普通线性回归|模型中没有空间自相关的影响|
|$\rho\not=0,\beta=0,\lambda=0$|一阶空间自回归模型|因变量受邻域内的其他因变量的影响|
|$\rho\not=0,\beta\not=0,\lambda=0$|空间滞后模型|Spatial Lag model，SLM,研究的因变量不仅与本区域的解释变量有关，还与相邻区域的因变量有关|
|$\rho=0,\beta\not=0,\lambda=0$|空间误差模型|Spatial Error Model，SEM，研究的因变量不仅与本区域的解释变量有关，还与相邻区域的解释变量有关|
|$\rho\not=0,\beta\not=0,\lambda=0$|空间杜宾模型|Spatial Dubin Model，SDM|

模型的选择步骤：先进行OLS回归，再进行LM-Lag和LM-Error（二者都基于Lagrange Multiplier，拉格朗日乘数诊断）诊断，若：

+ 诊断结果都不显著，则使用OLS即可
+ 有一个显著，若LM-Lag显著，则使用SLM；若LM-Error显著，则使用SEM
+ 若都显著，则进行Robust LM-Lag和Robust LM-Error诊断：
  + 若Robust LM-Lag显著，则使用SLM
  + 若Robust LM-Error显著，则使用SEM
  + 若都显著（一般只有一个显著），选择显著性大的统计量对应的回归模型

在本节的应用案例中也提到了判别分析（Discriminant Fuction Analysis），这里也作一简单回顾。

判别分析是判别样本所属类别的一种统计方法，是研究对象分成若干类型并已取得各种类型的一批已知样本的观测数据，在此基础上建立判别式，然后对未知类型的样本进行判别分类。（而对聚类分析而言，一批给定样本要划分的类别事先并不知道。需要通过聚类分析来确定类型，常与判别分析配合使用，即先聚类后判别），按《空间数据分析》一书，对三种判别准则作简单总结：

|判别方法|描述|评价|
|:----:|:----|:----|
|距离判别|根据已知分类的数据，分别计算各类的重心（各组的均值），判别准则是对任意给定样品，计算其到各类均值的距离1，哪个距离最小就将其归至哪个类|简单实用；未考虑先验概率，未考虑错判的损失|
|贝叶斯判别|计算被判样本$x$属于$k$个总体的条件概率$P(n\|x),n=1,2,3...,k$，比较$k$个概率的大小，将样本判归为出现概率最大的总体（或错判概率最小的总体）|样本分布往往不满足属性条件独立性假设|
|费歇尔判别|设有A、B两个总体，分别有$n_1、n_2$个样本数据，每个样本有$p$个观测指标，每个样本可以看作$p$维空间中的一点，借助方差分析的思想构建一个线性判别函数|Fisher LDA 在有监督的情况下，最大化地保留了分类信息，这一分类信息由一个非参指标，Fisher 指标来衡量；可能损失精度|

## 5.2 Nonlinear regression

In the preceding section, implementation of spatial autoregressive models requires nonlinear regression techniques but the error term assumption is still the normal probability model.

**Eigenvector spatial filtering** furnishes a sound methodology for estimating non-normal probability models with georeferenced data containing non-zero spatial autocorrelation. This methodology accounts for spatial autocorrelation in random variables by incorporating heterogeneity into parameters in order to model non-homogeneous populations. It renders a mixture of distributions that can be used to model observed georeferenced data whose various characteristics differ from those that are consistent with a single, simple, underlying distribution with constant parameters across all observations. The aim of this technique is to capture spatial autocorrelation effects with a linear combination of spatial proxy variables – namely, eigenvectors – rather than to identify a global spatial autocorrelation parameter governing average direct pairwise correlations between selected observed values. As such, it utilizes the misspecification interpretation of spatial autocorrelation, which assumes that spatial autocorrelation is induced by missing exogenous variables, which themselves are spatially autocorrelated, and hence relates to heterogeneity.

Eigenvector spatial filtering conceptualizes **spatial dependency** as common factor that is a linear combination of synthetic variates （the eigenvector of the matrix $\pmb{(I-11^T/n)C(I-11^T/n)}$） summarizing distinct features of the neighbors' geographic configuration structure for a given georeferenced dataset.

+ Binominal/Logistic regression
+ Poisson/negative binominal regression

这里涉及到广义线性模型 Generalized Linear Model，也作一简单回顾。

在GLM中，解释变量可以是连续变量或者名义变量，可以是连续的或者离散的，且因变量的线性预测值仅是解释变量的函数估计值，即因变量通过一个连接函数（可以是非线性的）依赖于自变量。

指数分布族（exponential family，如泊松分布、二项分布、几何分布等都属于指数分布族）：$f(y|\theta,\phi)=exp(\frac{y\theta-b(\theta)}{a(\theta)}+c(y,\phi))$，其中$\theta$为自然参数，与均值有关；$\phi$为散布参数，与方差有关；$a(\phi),b(\theta),c(y,\phi)$为已知函数。

一个GLM由以下三部分组成：

+ 系统成分：解释变量的线性组合，$\eta=X\beta$
+ 随机成分：因变量y或者说随机误差$\epsilon$的分布服从指数族分布，$\epsilon=Y-\eta$
+ 连接函数：将系统成分和随机成分连接起来的函数，由此得到GLM的一般形式：$g(Y)=X\beta+\epsilon$

应当采用最大似然法而非最小二乘法估计参数。

判断是否应该使用GLM的检验方法有Wald检验、约束检验和拟似然比检验等，原假设是符合线性模型的条件。

Logistic回归，将(0,1)区间内的变量映射到{0,1}中，则可以将对$y_i$的预测值替换为值为1的概率，则有$g(\mu)=ln[\frac{p}{1-p}]=X\beta+\epsilon$，从而得到$P=\frac{e^{X\beta+\epsilon}}{1+e^{X\beta+\epsilon}}$，其特点有：

+ 广泛用于分类问题
+ 要求样本量大（最大似然法估计参数的本身属性）
+ 不要求自变量和因变量之间存在线性关系

Poisson回归：基于事件计数变量（事件发生的次数）建立的回归模型，因变量的对数与解释变量呈线性关系，即$log(Y)=X\beta+\epsilon$