# Chapter 7 Analyzing Spatial Variance and Covariance with Geostatistics and Related Techniques

以下内容均来自《地理信息系统空间分析原理》第六章

地统计是针对空间场模型研究其中的空间相关性、并以之为基础进行空间预测的理论。其内容包括随机场的自相关性、空间结构分析理论、克里金插值理论、条件模拟理论等几个部分。

## 6.1 空间随机场

+ 随机变量
+ 随机函数：如果每次随机试验的一个实现是一个确定的函数$Z(x_1,x_2,...,x_n)$，那么所有实现的集合就称为随机函数$Z((x_1,x_2,...,x_n,w)$，其中$w$为每个实现，可以将其视作具有$n$个参数（$x_1\in{X_1},x_2\in{X_2},...,x_n\in{X_N}$）的随机变量族。
+ 随机过程：当随机函数中只有一种自变量t时，该随机函数被称为随机过程，记作$Z(t,w)$。
+ 随机场：当随机函数依赖于多个自变量，尤其是空间坐标时，称该随机函数为随机场。
+ 区域化变量：与空间坐标有关的随机场，记作$Z(x_u,x_v,x_w)$，简记为$Z(X)$。观测前认为区域化变量$Z(X)$是一个随机场；观测后区域化变量$Z(X)$就是一个普通的、与空间位置有关的多元空间函数。区域化变量有如下特点：


|性质|说明|
|:----:|:----|
|空间局限性|只在一定的空间范围内定义|
|随机性|在空间上的分布具有随机性，即使相近的两点属性值也可能有较大差别|
|结构性|距离较近的两点比距离较远的两点具有更大程度的相似性|
|各向异性||
|可迁性|区域化变量只在一定范围内呈现一定程度的空间自相关，当超出这一范围后自相关变弱以至于消失|
|叠加性|对不同的区域化变量可以进行叠加，其随机性、结构性也相应叠加|

## 6.2 变差函数

区域化变量在点$x$与点$x+h$处的值$Z(x)$与$Z(x+h)$之差的方差之半定义为区域化变量$Z(x)$的变差函数，并记作$\gamma(x,h)$，即：

$\gamma(x,h)=\frac{1}{2}Var(Z(x)-Z(x+h))=\frac{1}{2}E((Z(x)-Z(x+h))^2)-\frac{1}{2}(E(Z(x)-Z(x+h)))^2=\frac{1}{2}E((Z(x)-Z(x+h))^2)-\frac{1}{2}(E(Z(x))-E(Z(x+h)))^2$

常用的变差函数模型有球状模型、高斯模型和指数模型，其都由三部分组成：

+ 变程$a$：当两点之间的距离$h≤a$时，两点之间的随机变量具有相关性，相关性随着$h$的增大而减小；当两点之间的距离$h>a$时，就不再有相关性，同时也能反映区域变量的延展性或作用尺度；
+ 块金常数$C_0$：衡量两点之间的距离趋近0时其区域化变量之间的差异，描述空间随机场的粗糙程度，其越大说明空间随机场越粗糙；
+ 拱高$C$：反映了距离大于变程的两点之间的区域化变量差异，即某区域化变量的变异程度，$C$与$C_0$的和称为基台值。

二阶平稳假设（地统计的基本假设，进行变差函数计算及线性平稳克里金插值的先决条件）：即二阶平稳性假设（Second Stationary Assumption）又称弱平稳假设，其与协方差函数（Covariance Function）有关。这一假设认为，随机函数的期望为一常数，且任意两个随机变量之间的协方差仅仅依赖于其二者之间的距离与方向，而与其具体位置无关。：

+ $E(Z(x))=E(Z(x+h))=m$
+ $Cov(Z(x),Z(x+h))=E(Z(x)Z(x+h))-E(Z(x))E(Z(x+h))=E(Z(x)Z(x+h))-m^2=C(h)$

则令$h=0$，有$Cov(Z(x),Z(x+h))=E((Z(x))^2)-m^2=Var(Z(x))=C(0)$

则$\gamma(x,h)=\frac{1}{2}E((Z(x)-Z(x+h))^2)=E((Z(x))^2)-E(Z(x)Z(x+h))=\gamma(h)=C(0)-C(h)$，即协方差函数与变差函数之和为一常数。

本征假设（内蕴假设）：二阶平稳假设难以满足，放宽了限制条件：
+ $E(Z(X)-Z(X+h))=0$
+ $Var(Z(X)-Z(X+h))=E((Z(X)-Z(X+h))^2)=2\gamma (h)$

### 计算方法

样本数量有限，不可能计算任意$h$值下的变差函数值，常用的两种计算方法为：

（1）点对分组计算法：

$\gamma^*(h)=\frac{1}{2N(h)}\sum_{i=1}^{N(h)}{(Z(x)-Z(z+h))^2}$

其中，$N(h)$是研究区域内间隔为$h$（有距离，有方向）的样本点对数；$Z(x)$和$Z(x+h)$分别是$x$及$x+h$处的变量值。

计算得到不同方向的多个实验计算值，再进行拟合即可得到$\gamma(h)$

（2）点对云图计算法

逐一计算任意两样本点之间的距离$h$和$\gamma^{*}(h)$，然后将对$(h,\gamma^{*}(h))$散点进行拟合。

拟合方法：①选定某种模型（如最常用的是球状模型，可以是多层结构的叠加）；②参数拟合（如线性规划、遗传算法、加权多项式回归等方法）

变异函数模型可以分为三类：

+ 无基台值模型（包括幂函数模型、无基台值线性模型、对数模型等）
+ 有基台值模型（包括球状模型、指数模型、高斯模型、有基台值线性模型、纯块金效应模型等）
+ 孔穴效应模型（变异函数在$h$大于一定距离后并不继续单调递增，而是以一定的周期波动）

## 6.3 结构分析的理论与应用

评估空间随机场的可知度：

+ $h$：变异程度
+ $C_0$、$C_0+C$：绝对粗糙程度
+ $C_0/C$：相对粗糙程度

eg：甲烷各方向的变程、块金常数和基台值均比乙烷大，从$C_0/C$的结果来看，甲烷在4个方向上均低于乙烷。虽然甲烷的绝对粗糙程度高，但相对粗糙程度却较低，因此综合起来，甲烷所形成的空间随机场可知度较高。那么是什么原因造成以上的现象呢？我们可以作以下分析。首先，甲烷的分子量较乙烷小，所以甲烷的活动性就较乙烷强，在空间随机场中甲烷就表现为有较大的弥散性，从而解释了甲烷在更大的空间尺度上仍具有相关性，具体表现为甲烷具有较大的变程，而乙烷的变程较小；其次，也正是因为甲烷的活动性比较强，所以甲烷数据的跳跃性也相应较大，表现在变差函数的参数上，就是甲烷的块金常数$C_0$较乙烷大，即便如此。甲烷的$C_0/C$仍小于乙烷，说明甲烷的相对粗糙程度更低一些；最后，由于甲烷的空间弥散性强于乙烷，从而造成甲烷整体上的起伏更加剧烈，以至于基台值更大。总之，甲烷和乙烷在变差函数上所体现出的差别正是由它们的分子结构、地球化学性质等因素决定的。

不同空间随机场的性质存在差异，同一空间随机场内部的性质也存在差异（具体表现在：不同位置的性质不同；不同方向上的性质也不同（各向异性）），对空间各向异性的分析有助于了解区域化变量所处环境的性质、揭示形成各向异性的原因（如构造带的分布差异）。

变异函数分析步骤：区域化变量选择→数据获取与审议（点间距离、取样方法、数据代表性、数据均匀性、时空一致性、误差等）→数据统计分析（一般统计分析、异常值识别、正态分布检验、正态分布转换）→变异函数计算→变异函数结构分析→变异函数最优拟合及检验→变异函数模型专业分析

## 6.4 估计方差

估计误差：使用测量值$Z^*(x_i)$来估计真实值$Z(x_i)$时，会存在估计误差$R(x_i)=Z(x_i)-Z^*(x_i)$，有$E(R(x))=E(Z(x)-Z^*(x))=m_E$

估计方差：估计误差的方差，$Var(R(x))=E((Z(x)-Z^*(x))^2)-m_E^2=\sigma_E^2$，二阶平稳假设下，估计方差可以表示为：$\sigma_E^2=C(x,x)+\sum_{i=1}^n{\sum_{j=1}^n{{\lambda_i\lambda_jC(x_i,x_j)}}-2\sum_{i=1}^n{\lambda_iC(x,x_i)}}$，其中$C(x,x)$是未知点之间的协方差，$C(x_i,x_j)$是已知样本点之间的协方差，$C(x,x_i)$是未知点与已知样本点之间的协方差，假设$Z^*(x)=\sum_{i=1}^n{\lambda_iz(x_i)}$。

利用估计方差可以进行最佳采样间隔的确定等应用。

## 6.5 Krige方法原理

Krige方法（克里金方法）是地统计的核心，其与确定性方法的最大区别在于引入了概率模型，在进行预测时给出预测值的误差，即预测值在一定概率内合理，是一种局部估计的加权平均，实测点的权重通过半方差分析获取，从而使内插函数处于最佳状态。克里金法实质上是利用区域化变量的原始数据和变异函数的结构特点，对未采样点的区域化变量的取值进行线性无偏最优估计的一种方法。

各种克里金方法的使用情境：

+ 多元区域化变量
  + **协同克里金插值**（适用于相互关联的多元区域化变量）
+ 单元区域化变量
  + 线性克里金
    + 满足本征假设
      + 满足二阶平稳假设
        + **简单克里金插值**（满足本征假设，区域均值未知）
      + 不满足二阶平稳假设
        + **普通克里金插值**（满足二阶平稳假设，区域均值已知）
    + 不满足本征假设
      + **泛克里金插值**（区域变量的期望未知）
  + 非线性克里金
    + 对数转换后正态分布
      + **对数正态克里金插值**（取对数后的数据服从正态分布）
    + 转为(0,1)值
      + **指示克里金插值**（有真实的特异值，数据不服从正态分许，或需估计风险、概率分布，是非参数方法）

（1）普通克里金

Original Kriging，单个变量的局部线性最优无偏估计，最稳健最常用。

假设：区域化变量的均值是未知的常数$m$，$Z(x)$是满足本征假设的一个随机过程，该过程有$n$个观测值。要预测未采样点$x_0$的值，其线性预测值为$Z^*(x_0)=\sum\lambda_iZ(x_i)$。

+ 无偏性条件：$E(Z^*(x_0)-Z(x_0))=0$
+ 最优条件：$Var(Z^*(x_0)-Z(X_0))=min$

则有：

$E(Z^*(x_0)-Z(x_0))=E(\sum\lambda_iZ(x_i)-Z(x_0))=\sum\lambda_iE(Z(x_i))-E(Z(x_0))=\sum\lambda_im-m=m(\sum\lambda_i-1)=0\Rightarrow\sum\lambda_i=1$

$
Var(Z^*(x_0)-Z(x_0))\\
=E((Z*(x_0)-Z(x_0))^2)\\
=E((\sum\lambda_iZ(x_i)-Z(x_0))^2)\\
=E((\sum\lambda_iZ(x_i))^2)+E(Z(x_0)^2)-2E(\sum\lambda_iZ(x_i)Z(x_0))\\
=Cov(\sum\lambda_iZ(x_i),\sum\lambda_iZ(x_i))+(E(\sum\lambda_iZ(x_i)))^2+Cov(Z(x_0),Z(x_0))+(E(Z(x_0)))^2-2(Cov(Z(x_0),\sum\lambda_iZ(x_i))+E(Z(x_0))E(\sum\lambda_iZ(x_i)))\\
=Cov(\sum\lambda_iZ(x_i),\sum\lambda_iZ(x_i))-2Cov(Z(x_0),\sum\lambda_iZ(x_i))+Cov(Z(x_0),Z(x_0))\\
=\sum\sum\lambda_{i}\lambda_{j}Cov(Z(x_i),Z(x_j))-2\sum\lambda_iCov(Z(x_i),Z(x_0))+Cov(Z(x_0),Z(x_0))\\
=\sum\sum\lambda_{i}\lambda_{j}C(i,j)-2\sum\lambda_iC(i,0)+C(0,0)\\
=\sum\sum\lambda_{i}\lambda_{j}(\sigma^2-\gamma_{ij})-2\sum\lambda_i(\sigma^2-\gamma_{i0})+\sigma^2-\gamma_{00}$

（$\gamma$是变差函数）

$=-\sum\sum\lambda_{i}\lambda_{j}\gamma_{ij}+2\sum\lambda_i\gamma_{i0}-\gamma_{00}$

（利用$\sum\lambda_i=1$的性质）

即转换为有约束的最小值求解问题，使用拉格朗日乘子法求解系数$\lambda_i$即可

（2）简单克里金

假设：区域化变量的数学期望已知，且为一常数：$E(Z(x))=m$

预测公式：$Z^*(x_0)=\sum\lambda_i(Z(x_i))+(1-\sum\lambda_i)\mu$

参数估计：$\sum\lambda_i\gamma(x_i,x_j)=\gamma(x_0,x_j), j=1,2,..,n$



【其他克里金方法不再详细介绍】

## 6.6 克里金方法应用实例

## 6.7 克里金方法的发展

+ 泛克里金
+ 非线性克里金
+ 协同克里金
+ 时空克里金（参数方法，以不同空间随机变量的互相关信息为核心）
+ 指示克里金（非参数方法，以条件概率为核心）

**以下内容是来自SSGS英文书的补充**

## 7.3 Spatial linear operator

(本节主要内容就是使用空间算子消除空间自相关)

Spatial linear operator construction ($I-\rho{W}$) via spatial autoregression supports a Cochrane-Orcutt type of pre-whitening of georeferenced data.

(Prewhitening is an operation that processes a time series (or some other data sequence) to make it behave statistically like white noise. The ‘pre’ means that whitening precedes some other analysis that likely works better if the additive noise is white.)

### Multivariate geographic data

Principal components analysis (PCA) and factor analysis (FA) address multicollinearity latent in a battery of variables. Eigenvector spatial filtering directly relates to PCA (see Sections 4.2.1 and 5.2). Multivariate ANOVA (MANOVA) addresses the difference-of-means problem involving a battery of variables. Canonical correlation analysis (CCA) addresses a pair of variable sets.

(Multicollinearity is a term used in data analytics that describes the occurrence of two exploratory variables in a linear regression model that is found to be correlated through adequate analysis and a predetermined degree of accuracy. The variables are independent and are found to be correlated in some regard.)

下面对FA、MANOVA、CCA作一简单介绍。

### FA

因子分析是一种数据简化的技术。它通过研究众多变量之间的内部依赖关系，探求观测数据中的基本结构，并用少数几个假想变量来表示其基本的数据结构。这几个假想变量能够反映原来众多变量的主要信息。原始的变量是可观测的显在变量，而假想变量是不可观测的潜在变量，称为因子。（主成分分析是将主要成分表示为原始观察变量的线性组合，而因子分析是将原始现察变量表示为新因子的线性组合，原始观察变量在两种情况下所处的位置不同。）对于因子分析，一般可以分为以下几个步骤：
+ 充分性检验（检验变量之间是否存在相关性，判断是否适合做因子分析）：抽样适合性检验（KMO检验）和巴特利特检验（Bartlett’s Test）；
+ 选择因子个数（通过数据定义最合适的潜在公共因子个数）：Kaiser”s准则或者累积贡献率原则；
+ 提取公共因子并做因子旋转：一般求解方法有：主成分法、最大似然法、残差最小法等等；因子旋转的原因是提取公共因子的解有很多，而因子旋转后因子载荷矩阵将得到重新分配，可以使得旋转后的因子更容易解释。常用的方法是方差最大法；
+ 对因子做解释和命名（解释和命名其实是对潜在因子理解的过程）：根据因子载荷矩阵发现因子的特点；
+ 计算因子得分：对每一样本数据，得到它们在不同因子上的具体数据值，这些数值就是因子得分。

### MANOVA

多元方差分析，对有一种以上响应变量(因变量)数据的方差分析。

前提假设是：各响应变量的联合分布为多元正态分布；数据来自随机样本，观察值间独立；每个样本的协方差矩阵均相同；响应变量间存在一定相关系。

一些统计量：Pillai’s迹：恒为正数，值越大，表明该效应项对模型的贡献越大；Wilks’Lambda：取值范围在0～1之间，值越小，说明该效应项对模型的贡献越大（此时应当拒绝$H_0$）；Hotelling迹：检验矩阵特征根之和。与Pillai’s轨迹相似，值越大贡献越大；Roy最大根统计量：为检验矩阵特征根中最大值。

### CCA

典型关联分析，其基本思想是将高维数据X和Y变换到一维X'和Y'，再进行相关系数的计算。降维标准是降维到一维后，两组数据的相关系数最大。

### 7.4 Eigenvector spatial filtering: correlation coefficient decomposition

(本节主要内容就是使用特征向量空间滤波消除空间自相关，从而得到更准确的相关系数)

One advantage of constructing eigenvector spatial filtering is that a spatial autocorrelation effect can be separated into a commonality and variable-specific components.

Latent spatial autocorrelation can alter a correlation coefficient in both strength and sign. Spatial filtering separates a variable into two parts. The first is a linear combination of common plus unique eigenvector. The second ia aspatial residuals, which are non-geographic component of attributes.

$X=\hat{X_C}+\hat{X_U}+e_X$

$Y=\hat{Y_C}+\hat{Y_U}+e_Y$