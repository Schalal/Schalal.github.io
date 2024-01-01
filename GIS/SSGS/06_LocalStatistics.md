# Chapter 6 Local Statistics: Hot and Cold Spots

## 6.1 Mutiple testing with psoitively correlated data

Bonferroni adjustment: the decided-upon overall alpha level ($$a^*$$) statistical significance is divided by n. (Bonferroni correction states that if an experimenter is testing n independent hypotheses on a set of data, then the statistical significance level that should be used for each hypothesis separately is 1/n times what it would be if only one hypothesis were tested.)

即如果在同一数据集上同时检验n个独立的假设，那么用于每一假设的统计显著水平，应为仅检验一个假设时的显著水平的1/n（过于严格，容易出现“假阳性”现象）。

## 6.2 Local indices of spatial association

即LISA，我们已经在[第二章](./02_SpatialAutocorrelation.md)中介绍过了，这里再对其推导过程作一介绍。

$$MC=\frac{n}{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}}\frac{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}(Y_i-\overline{Y})(Y_j-\overline{Y})}{\sum_{i=1}^{n}{(Y_i-\overline{Y})^2}}=\frac{1}{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}}\frac{\sum_{i=1}^{n}{(Y_i-\overline{Y})\sum_{j=1}^{n}{c_{ij}}}(Y_j-\overline{Y})}{\sqrt{\sum_{i=1}^{n}{(Y_i-\overline{Y})^2/n}}\sqrt{\sum_{i=1}^{n}{(Y_i-\overline{Y})^2/n}}}=\frac{1}{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}}\sum_{i=1}^n{z_i}\sum_{j=1}^n{c_{ij}}\sum_{j=1}^n{z_j}$$<br>
则局部MC实质上就是：
$$MC_i=z_i\sum_{j=1}^n{c_{ij}}z_j$$

## 6.3 Getis-Ord statistics

也在[第二章](./02_SpatialAutocorrelation.md)中介绍过了，对$$G^*$$公式作一介绍：

$$G_i^*=\frac{\sum_{j=1}^{n}w_{ij}(d)x_j-\overline{x}\sum_{j=1}^n{w_{ij}}}{s_x\sqrt{\frac{(n-1)\sum_{j=1}^{n}{w_{ij}^2(d)-(\sum_{j=1}^n{w_{ij}(d)})^2}}{n-2}}}$$，其中$$s_x$$表示$$x$$的标准差，$$w_{ij}(d)$$表示当前要素$$i$$与在距离阈值$$d$$内的要素$$j$$的空间权重。

## 6.4 Spatially varying coefficient

Local statistics seek to address one feature of the more general theme of geographically varying relationship. A geographically varying mean is the focus in specifications such as the standard spatial autoregressive and spatial filtering models. This type of specification can be also extended to regression coefficient.

One technique producing such geographically varying coefficients requires the construction of interaction variables with a set of candidate spatial filter eigenvectors and geographic variables (Griffith, 2008). Then geographically varying coefficients may be determined by employing a stepwise regression selection technique, followed by factoring each X variable from the set of interaction terms containing it. The sum of the resulting set of eigenvectors for each X furnishes geographically varying coefficients.

这里提到的stepwise regression，就是逐步回归。逐步回归的基本思路是从大量可供选择的变量中选取最重要的变量，建立回归分析的预测或者解释模型。其基本思想是：将自变量逐个引人，引入的条件是其偏回归平方和经检验后是显著的。同时，每引人一个新的自变量后，要对旧的自变量逐个检验，剔除偏回归平方和不显著的自变量。这样一直边引入边剔除，直到既无新变量引人也无旧变量删除为止。它的实质是建立“最优”的多元线性回归方程。

地理加权回归应当也属于此类局部模型，这里只不过使用的是Spatial Filter Eigenvector，这里对地理加权回归（Geographical Weighted Regression）作一介绍，其形式为

$$y_i=\beta_{i0}+\sum_{k=1}^p{\beta_{ik}x_{ik}}+\epsilon_{i}=\beta_{0}(u_i,v_i)+\sum_{k=1}^p{\beta_{k}(u_i,v_i)x_{ik}}+\epsilon_{i}$$，其中$$(u_i,v_i)$$是第$$i$$个采样点的坐标，$$\beta_{k}(u_i,v_i)$$是第$$i$$个采样点的第$$k$$个回归参数，随机误差$$\epsilon_{i}$$满足iid。

可知，一共有$$n\times(p+1)$$个参数需要估计，而观测数据只有$$n$$个，所以不能用参数方法进行估计，只能使用非参数的光滑方法，即假设回归参数为一连续表面，位置邻近的回归参数非常相似，在估计采样点$$i$$的回归参数时，以采样点及其邻域采样点上的观测值构成局部样本子集，对该子集进行全局线性回归，然后使用OLS进行参数估计，因为使用了邻域点的观测值估计参数，所以参数估计是有偏的。

邻域的确定与“带宽有关”，可以通过交叉验证、AIC准则、BIC准则、平稳指数、自适应权函数（不同点采用不同的带宽，常用思路是选取最邻近的k个点使用高斯函数或双重平方函数进行带宽的计算）。

一般而言，越近的邻域点对当前点有更强的影响，所以进行地理加权时还需要考虑权重，权重一般由权函数确定，邻域内的样本权重构成一个权重阵，这是一个对角阵。

基于权重阵再使用加权最小二乘回归（WLS）进行参数估计即可。

GWR和OLR的哪一个更好的检验方法可以是拟合优度检验，从而检验整体上是否存在空间非平稳性；可以进一步对每个回归参数进行检验，看其是否有空间非平稳性；还可以通过比较两个模型的AIC看哪个模型更好。

基于一般的GWR，还有衍生的混合GWR（一部分参数为常参数，即其值不随空间位置变化）、地理加权广义线性模型、时空地理加权回归、地理加权主成分分析（均值、方差、协方差阵都考虑地理权值$$w(u,v)$$的影响）等。

