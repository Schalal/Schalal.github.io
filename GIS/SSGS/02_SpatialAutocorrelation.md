# Chapter 2 Spatial Autocorrelation

Much of classical statistical theory assumes that observations are iid (independent and identically distributed).

Correlated samples theory: repeated measures ----> multivariate statistical theory: observations are paired with the distribution of pairs being iid while pairs themselves are correlated.

（也就是一组观测值与另一组观测值认为无关，但一组观测值内的各个变量认为是相关的，所以称为autocorrelation）

----> time series analysis  ----> spatial series analysis (spatial autocorrelation)

## 2.1 Indices measuring spatial dependency

### Moran coefficient (MC)

+ a covariation measurement that relates directly to the Pearson product moment coeffient（也就是皮尔逊相关系数，即Pearson correlation coefficient）.
+ is capable of indexing data across all four scales (nominal, ordinal, interval and ratio).
+ PPMCC:

$\rho=\frac{\sum_{i=1}^{n}{1(x_i-\overline{x})(y_i-\overline{y})}/n}{\sqrt{\sum_{i=1}^{n}{(x_i-\overline{x})^2}/n}\sqrt{\sum_{i=1}^{n}{(y_i-\overline{y})^2}/n}}=\frac{\sum_{i=1}^{n}{(x_i-\overline{x})(y_i-\overline{y})}}{\sqrt{\sum_{i=1}^{n}{(x_i-\overline{x})^2}}\sqrt{\sum_{i=1}^{n}{(y_i-\overline{y})^2}}}$

+ where
  + 1 is the frequency of observation $i$;
  + $x_i$ and $y_i$ are paired values of two variables for observation $i$;
  + $\overline{x}$ and $\overline{y}$ are the respective mean of these two variables;
  + the numerator is a covariation term and the denominator is the product of the standard deviations of the two variables;
  + division by $n$ can be replaced by $n-1$ for unbiased estimates.

+ MC for variable Y (similar to PPMCC):

$MC=\frac{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}(y_i-\overline{y})(y_j-\overline{y})/\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}}}}{\sqrt{\sum_{i=1}^{n}{(y_i-\overline{y})^2}/n}\sqrt{\sum_{j=1}^{n}{(y_i-\overline{y})^2}/n}}=\frac{n}{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}}\frac{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}(y_i-\overline{y})(y_j-\overline{y})}}}{\sum_{i=1}^{n}{(y_i-\overline{y})^2}}$

+ where
  + $c_{ij}$ is the corresponding cell value in the distance matrix that replaces the frequence 1 in PPMCC.
  + autocorrelation refers to correlation with in a single variable.
  + 计算时空间权重阵一般需要进行行标准化

### Important properties of MC

+ the range of MC is no longer [-1, 1] -- this interval maybe shrink, but usually expands -- and midpoint is $\frac{1}{n-1}$ rather than 0 with denoting 0-spatial autocorrelation.（对于正方形剖分的空间而言，MC的值域仍然为[-1,1]，正值越大表明空间上出现了属性相似的聚集（高-高，低-低），负值的绝对值越大表明出现了属性相反的聚集（高-低，低-高），越接近0表明在空间上的关联性越小）。
+ $H_0$: $n$个观测单元的属性值不存在空间自相关的关系，标准化MC $Z_\alpha=\frac{I-E(I)}{\sqrt{Var(I)}}$，其中I就是MC的值，$E(I)$是MC的期望，$Var(I)$是MC的方差，具体值比较复杂，可以参照MORAN P A P. Notes on continuous stochastic phenomena.[J]. Biometrika,1950,37(1-2). 还可以证明，在零假设成立的情况下，$Z_\alpha$近似服从正态分布，可以根据 $Z_\alpha$ 判断是否存在着空间自相关现象。
+ MC方差的渐进值为$\frac{2}{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}}$，对于非正态分布，观测区域数至少为25，最好至少100。

### Geary Ratio (GR)

+ a paired comparisons measure that related directly to the semi-variogram plot utilized in geostatistics.
+ GR=$\frac{(n-1)\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}(x_i-x_j)^2}{2\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}\sum_{k=1}^{n}{(x_k-\overline{x})^2}}$
+ GR的值一般在[0,2]，大于1表示负相关，等于1表示不相关，小于1表示正相关，GR的标准化方式与MC的类似，也服从渐近正态分布，正的Z(GR)表示高值聚集，负的Z(GR)表示低值聚集。
+ 计算GR时，空间权重阵一般不进行行标准化。

### Relationships between MC and GR

$GR=\frac{n-1}{2\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}}}}\frac{\sum_{i=1}^{n}{(x_i-\overline{x})^2}(\sum_{j=1}^{n}{c_{ij}})}{\sum_{i=1}^{n}{(x_i-\overline{x})^2}}-\frac{n-1}{n}MC$

这也与上述两个系数之间的属性相符（inverse relationship）,GR也更容易受离群值影响，如果GR+MC≈1，那么说明数据质量较好（没有极端离群值），因为GR变化的范围更大（更不稳定），且MC在任意量表下都适用，所以MC是更优的度量空间自相关的指数。

### 小结——二者的比较

|Method|MC|GR|
|:----:|:----|:----|
|What does it measure?|Clustering data across the space|Dissimmilarities between data points  of juxtaposition|
|What's the reference?|Global mean of data points|Differences between neighboring data points|
|Similar to|PPMCC|Variogram|
|Weakness|Have to know the mean|Not influenced by sample size and spatial weight:less robust statistics|

### 补充：Getis-Ord G

+ Indicates that if high or low values are clusterred (only global status), but not for both.
+ $G=\frac{\sum_{i=1}^{n}{\sum_{j=1}^{n}{c_{ij}x_ix_j}}}{\sum_{i=1}^{n}{\sum_{j=1}^{n}{x_ix_j}}}$
+ 若是热点区域，则G值将较大；反之，若是冷点区域，则G值将较小。
+ 变体：$G_i^*$检验，用于寻找局部聚类，$G_i^*=\frac{\sum_{j=1}^{n}c_{ij}x_i}{\sum_{j=1}^{n}{x_j}}$，再标准化即可进行判别。

## 2.2 Graphic portrayals: the Moran scatterplot and semi-variogram plot

The Moran scatterplot is a two-dimensional diagram using Cartesian coordinates to display pairs of values in a manner that summarizes the relationship between the observations comprising a univariate georeferenced dataset.

Methods:

+ Step1: Convert each $y_i$ to a z-score.
+ Step2: Plot each z-score (horizontal axis) against its corresponding sum of **surrounding** z-scores (vertical axis).

注意：这里的莫兰散点图也就是所谓的LISA（Local Indicators of Spatial Association）图，只不过表述方式有区别（《空间数据分析》教材上的表述是“描述观测变量$x$和其空间滞后变量$W_x$（即该空间单元周围单元的观测变量的值得加权平均值）”），LISA图的斜率就是未标准化的MC（需要除以距离矩阵权重之和），右上、左下、右下、左上四个区域分别代表高-高、低-低、高-低、低-高四种聚类形式。

这里再来补充一下局部莫兰指数的定义。

探究是否存在观测值的局部聚集、哪个空间单元对全局空间自相关的有更大的贡献时，需要使用局部空间自相关分析。局部莫兰指数就是一种常用的度量指数。

$MC_i=\frac{(x_i-\overline{x})}{S^2}\sum_{j=1}^{n}{c_{ij}(x_j-\overline{x})}=\frac{n(x_i-\overline{x})\sum_{j=1}^{n}{c_{ij}(x_j-\overline{x})}}{\sum_{i=1}^{n}{(x_i-\overline{x})^2}}=\frac{nz_i\sum_{j=1}^{n}{c_{ij}z_j}}{Z^TZ}$

其中 $S^2=\frac{\sum_{i=1}^{n}{(x_i-\overline{x})^2}}{n}$, $\overline{x}=\frac{1}{n}\sum_{i=1}^{n}{x_i}$, $z_i$ 和 $z_j$是经过标准差标准化后的观测值。

有$\sum_{i=1}^{n}{MC_i}=S_0MC$

（此外，Join Count统计量也是一种衡量空间自相关的方法（主要用于衡量名义量表变量的空间自相关，也有简单的介绍，这里跳过了）

The semi-variogram scatterplot is a two-dimensional diagram using Cartesian coordinates of the first quadrant (i.e., all values are non-negative) to display pairs of values in a manner that summarizes the relationship between the **variation** for a univariate georeferenced variable and distance separating the georeferenced observations.

也就是变差函数图，横轴为标准化之后的距离，纵轴为半方差值，与横轴为Topological Lag（空间滞后），纵轴为GR值的散点图趋势一致（因为二者都与方差有关），由三个主要部分组成：

+ 变程（Range）: the distance at which spatial autocorrelation becomes zero.
+ 块金常数（Nugget）: a discontinuity at the origin, such that the trend line doesn't go to zero when the distance is zero.
+ 基台值（Sill）: the limit of the trend line implied by the scatter of points as distance goes to infinity.

(后面应该还会见到)

## 2.3 Impacts of spatial autocorrelation

Variance Inflation

也就是方差膨胀，变量之间存在着相关性（多重共线性）

## 2.4 Testing for spatial autocorrelation in regression residuals

回归残差的空间自相关检验，对于不同的回归方程Cliff和Ord给出了不同的检验量。（跳过）

## 2.5 R Code for concept implementations

+ spdep
+ listw
+ ...


00100000
11000000

00000000

