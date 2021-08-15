# Chapter 5 Spatially Adjusted Regression and Rekated Spatial Econometrics

Classical statistics attaches a probability distribution to the residuals of prediction equation. Spatial statistics modifies this situation by specifying a prediction function that has $Y$ on both sides of the equation, which means that a value at location $i$ is at least partially a function of the values of $Y$ at nearby locations. This conceptualization captures the essence of spatial autocorrelation.

## 5.1 Linear regression

SAR, simultaneous autoregression:

$Y=\rho\bold{W}Y+(\bold{I}-\rho\bold{W})\bold{X}\pmb{\beta}+\pmb{\epsilon}$

where:

+ $\bold{W}$ is the row standardized spatial weight matrix, also called row standardized geographic connectivity matrix;
+ $\bold{I}$ is an $n*n$ identity matrix;
+ $\rho$ is the spatial autocorrelation parameter;
+ $\pmb{\beta}$ is a $(P+1)*1$ vector of regression coefficients (including the intercept term);
+ $\pmb{\epsilon}$ is an $n*1$ vector of iid $N(0,\sigma^2)$, which can be written in matrix form as the multivariate normal distribution $MVN(\bold{0},\bold{I}\sigma^2)$

If considering $\epsilon$ in the standard linear regression model $Y=\bold{X}\pmb{\beta}+\epsilon$ is spatial auto-related, then the model can be written as $Y=\bold{X}\pmb{\beta}+(\bold{I}-\rho\bold{W})^{-1}\epsilon$, and the spatial regression equation can be written as:

$Y=\bold{X}\pmb{\beta}+[\rho\bold{W}(Y-\bold{X}\pmb{\beta})+\pmb{\epsilon}]=\bold{X}\pmb{\beta}+\xi$

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

## 5.2 Nonlinear regression
