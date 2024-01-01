# Chapter 9 More Advanced Topics in Spatial statistics

Statistical methods in Chapter 2-8 are known as frequentist methods, which assumes that parameters are fixed constant and affiliated probability distributions consisit of relative frequencies. A competing view, known as Bayesian methods, assumes that unknown parameters are random variables having distributions, and affiliated probability distributions reflect degrees of belief. 

Chapter 3 presents the bootstrap and jackknife resampling techniques. It alludes to the more general technique of Monte Carlo simulation. Bayesian numerical estimation techniques also employ Monte Carlo simulation.

Chapter 8 emphasizes the utility of prediction error maps: in kriging, for example, mean response maps always should be accompanied by prediction maps. Researches need to be aware of sources of error in special data, as well as the how spatial autocorrelation impacts these sources.

## 9.1 Bayesian methods for spatial data

A contrast of frequentist methods and Bayesian methods:

|Feature|Frequentist|Bayesian|
|:----:|:----|:----|
|Definition of probability|Long-run expected frequency in repeated (actual or hypothetical) experiments (law of large numbers)|Relative degree of belief in the state of the world|
|Point estimate|Maximum likelihood estimate (LRT)|Mean, mode, or median of the posterior probability distribution|
|Confidence intervals for parameters|Based on the likelihood ratio test|"Credible intervals" based on the posterior probability distribution|
|Confidence intervals for non-parameters|Based on likelihood profile/LRT, or by resampling from the sampling distribution of the parameter|Calculated directly from the distribution of parameters|
|Model selection|Discard terms that are not significantly different from a nested (null) mode at a previously set confidence level|Retain terms in models, on the argument that processes are not absent simply because they are not statistically significant|
|difficulties|Confidence intervals are confusing (range that will contain the true value in a proportion $$\alpha$$ of repeated experiments); rejection of model terms for "not significance"|Subjectivity;need to specify priors|

即对于贝叶斯方法而言，观察者持有某个前置信念（prior belief），通过观测获得统计证据（evidence），通过满足一定条件的逻辑一致推断得出的关于该陈述的「合理性」，从而得出后置信念（posterior belief）来最好地表征观测后的知识状态（state of knowledge）。这里，贝叶斯概率推断所试图解决的核心问题就是如何构建一个满足一定条件的逻辑体系赋予特定论断一个实数所表征的论断合理性的度量（measure of plausibility），从而可以允许观测者在不完全信息的状态下进行推断。这里，观察者对某变量的信念或知识状态就是频率学派所说的「概率分布」，也就是说，观察者的知识状态就是对被观察变量取各种值所赋予的「合理性」的分布。从这个意义上来讲，贝叶斯概率论试图构建的是知识状态的表征，而不是客观世界的表征。因此，在机器学习、统计推断中，许多情况下贝叶斯概率推断更能解决观察者推断的问题，而绕开了关于事件本体的讨论，因为没有讨论本体的必要性。[参考](https://www.zhihu.com/question/20587681)

Historically, the complexity of normalizing factors in Bayesian analysis restricted implementation to those cases having analytical solutions. Today, the combination of Markov chain theory and Monte Carlo simulation techniques enables implementation for a much wider range of prior-likelihood pairings. Markov chain Monte Carlo (MCMC) is used to simulate the values from some posterior distributions known only up to a constant factor, namely the normalizing factor.

One serious consideration in MCMC analysis is convergence of the generated Markov chain. Each iteration can be treated as a point in time, allowing employment of time series techniques for diagnostic purposes. An analysis must discard the beginning set of simulated results to avoid arbitrary initial parameter estimates corrupting the final estimate. Next,  assessment of a time-series correlogram reveals whether or not sequential iterations contain serial correlation. In cases where substantial serial correlation exists, a chain should be weeded(i.e., only every kth output is returned). The trade- off here is the need to generate considerably more iterations in order to obtain uncorrelated outcomes. Fitting a trendline to the resulting sample values should yield a trend line. The slope of essentially zero. Finally, a comparison of multiple change, say with ANOVA techniques, furnishes information regarding convergence: within-chains variance should dominate between-chains variance.

Incorporation of spatial structure conventionally involves a conditional autoregressive (CAR) model specification for the random effects term. This specification employs a smaller geographic field and captures a weaker level of spatial correlation than the SAR model described in Section 5.1. Because of difficulties in estimating the spatial autocorrelation parameter for this specification, analysts frequently include an improper CAR (ICAR) model, where the spatial autocorrelation parameter is set to its maximum value, followed by estimation of a spatially unstructured random effects term. The final terms are the relative variances for these two terms.

以下内容来自清华大学的ppt：

### 蒙特卡洛法

蒙特卡罗法（Monte Carlo method)，也称为统计模拟方法（statistical simulation method)，是通过从概率模型的随机抽样进行近似数值计算的方法。

马尔可夫链蒙特卡罗法（Markov Chain Monte Carlo, MCMC)，则是以马尔可夫链（Markov chain)为概率模型的蒙特卡罗法。

马尔可夫链蒙特卡罗法构建一个马尔可夫链，使其平稳分布就是要进行抽样的分布，首先基于该马尔可夫链进行随机游走，产生样本的序列，之后使用该平稳分布的样本进行近似数值计算。

Metropolis-Hastings算法是最基本的马尔可夫链蒙特卡罗法；吉布斯抽样（Gibbs sampling）是更简单、使用更广泛的马尔可夫链蒙特卡罗法；马尔可夫链蒙特卡罗法被应用于概率分布的估计、定积分的近似计算、最优化问题的近似求解等问题，特别是被应用于统计学习中概率模型的学习与推理，是重要的统计学习计算方法。

蒙特卡罗法要解决的问题是，假设概率分布的定义己知，通过抽样获得概率分布的随机样本，并通过得到的随机样本对概率分布的特征进行分析。比如从样本得到经验分布，从而估计总体分布或者从样本计算出样本均值，从而估计总体期望。所以蒙特卡罗法的核心是随机抽样(random sampling)。 

### 马尔科夫链

考虑一个随机变量的序列$$X=\{X_0,X_1,…,X_t,…\}$$，这里$$X_t$$表示时刻t的随机变量。每个随机变量X_t(t= 0,1,2,…)的取值集合相同，称为状态空间，表示为$$S$$。随机变量可以是离散的，也可以是连续的。以上随机变量的序列构成随机过程( stochastic process)。假设在时刻0的随机变量$$X_0$$遵循概率分布$$P(X_0)= T_0$$，称为初始状态分布。在某个时刻t≥1的随机变量$$X_t$$与前一个时刻的随机变量$$X_{t-1}$$之间有条件分布$$P(X|X_{t-1})$$，如果$$X_t$$只依赖于$$X_{t-1}$$，而不依赖于过去的随机变量$$\{X_0,X_1,…,X_{t-2}\}$$，这一性质称为马尔可夫性，即$$P(X_t|X_0,X_1,...,X_{t-1})=P(X_t|X_{t-1})$$。具有马尔可夫性的随机序列$$X=\{X_0,X_1,… ,X_t,…\}$$称为马尔可夫链(Markov chain)或马尔可夫过程(Markov process)。条件概率分布$$P(X|X_{t-1})$$称为马尔可夫链的转移概率分布。转移概率分布决定了马尔可夫链的特性。直观解释是“未来只依赖于现在，与过去无关”，若转移分布概率与$$t$$无关，即$$P(X_t|X_{t-1})=P(X_{t+s}|X_{t+s-1})$$，则称该链是时间齐次的

离散状态马尔可夫链：随机变量定义在离散空间S，转移概率分布可以由转移概率矩阵P表示，若马尔可夫链在时刻(t-1)处于状态j，在时刻t移动到状态i，将转移概率记作$$p_{ij}=P(X_t=i|X_{t-1}=j)$$，满足$$p_{ij}\ge{0},\sum{p_{ij}}=1$$。考虑马尔可夫链在时刻t的概率分布，称为时刻t的状态分布，记作$$\pi_i(t)$$。有限离散状态的马尔可夫链可以由有向图表示，结点表示状态，边表示状态之间的转移，边上的数值表示转移概率。从一个初始状态出发，根据有向边上定义的概率在状态之间随机跳转（或随机转移），就可以产生状态的序列。有$$\pi_{i}(t)=P\pi_i(t-1)$$，进而有$$\pi_{i}(t)=P^t\pi_i(0)$$。

平稳分布：如果状态空间S上存在一个分布$$\pi$$，使得$$\pi=P\pi$$，则称$$\pi$$是一个平稳分布。直观上，如果马尔可夫链的平稳分布存在，那么以该平稳分布作为初始分布，面向未来进行随机状态转移，之后任何一个时刻的状态分布都是该平稳分布。马尔可夫链可能存在唯一平稳分布，无穷多个平稳分布，或不存在平稳分布。

连续状态马尔可夫链：随机变量定义在连续状态空间S，转移概率分布由概率转移核或转移核(transition kernel）表示，任意的$$x\in S,A\subset S, p(x,A)=\int_Ap(x,y)dy$$，其中$$p(x,·)$$是概率密度函数，有$$p(x,·)\geq 0, \int_Sp(x,y)dy=1$$，称$$P(x,A)=P(X_t=A|X_{t-1}=x)$$为转移核。若$$\forall y\in S, \pi(y)=\int p(x,y)\pi(x)dy$$，则称$$\pi(x)$$是其一个平稳分布。

对马尔科夫链若存在时刻$$t$$，有$$P(X_t=i|X_0=j)\gt 0, \forall i、j\in S$$，则称该马尔科夫链是不可约(inreducible)的，否则是可约的。直观上，一个不可约的马尔可夫链，从任意状态出发，当经过充分长时间后，可以到达任意状态。

对马尔科夫链$$\forall i\in S$$，如果时刻0从状态i出发，t时刻返回状态i的时长的最大公约数为1，则称改链是非周期的(aperiodic)，否则是周期的。直观上，一个非周期性的马尔可夫链，不存在一个状态，从这一个状态出发，再返回到这个状态时所经历的时间长呈一定的周期性。

定理：不可约的非周期的有限马尔科夫链，有唯一的平稳状态分布存在。

对马尔科夫链$$\forall i\in S, \lim\limits_{t\rightarrow\infin}p_{ij}^t\gt 0$$，则称该链是正常返（positive recurrent）的。直观上，一个正常返的马尔可夫链，其中任意一个状态，从其他任意一个状态出发，当时间趋于无穷时，首次转移到这个状态的概率不为0。

遍历定理：若马尔科夫链是不可约、非周期和正常返的，则有唯一的平稳状态$$\pi=(\pi_0,\pi_1,...)$$，且$$\lim\limits_{t\rightarrow\infin}P(X_t=i|X_0=j)=\pi_i$$。若$$f(X)$$是定义在状态空间上的函数，$$P(\frac{1}{t}\sum_{s=1}^{t}{f(x_s)\rightarrow\sum_{i}{f(i)\pi}})=1$$。遍历定理的直观解释：满足相应条件的马尔可夫链，当时间趋于无穷时，马尔可夫链的状态分布趋近于平稳分布，随机变量的函数的样本均值以概率1收敛于该函数的数学期望。样本均值可以认为是时间均值，而数学期望是空间均值。遍历定理实际表述了遍历性的含义：当时间趋于无穷时，时间均值等于空间均值。遍历定理的三个条件：不可约、非周期、正常返，保证了当时间趋于无穷时达到任意一个状态的概率不为0。

对马尔科夫链$$\forall t, p_{ij}\pi_i=p_{ji}\pi_j$$，则称该链是可逆马尔科夫链。直观上，如果有可逆的马尔可夫链，那么以该马尔可夫链的平稳分布作为初始分布，进行随机状态转移，无论是面向未来还是面向过去，任何一个时刻的状态分布都是该平稳分布。 

### 马尔可夫链蒙特卡洛法

马尔可夫链蒙特卡罗法适合于随机变量是多元的、密度函数是非标准形式的、随机变量各分量不独立等情况。假设多元随机变量$$x$$，满足$$x\in X$$，其概率密度函数为$$p(x)$$, $$f(x)$$为定义在$$X$$上的函数。目标是获得概率分布$$p(x)$$的样本集合，以及求函数$$f(x)$$的数学期望$$E_{p(x)}[f(x)]$$。

在随机变量x的状态空间S上定义一个满足遍历定理的马尔可夫链$$X={X_0,X_1,...,X_t,...}$$，使其平稳分布就是抽样的目标分布p(x)。然后在这个马尔可夫链上进行随机游走，每个时刻得到一个样本。根据遍历定理，当时间趋于无穷时，样本的分布趋近平稳分布，样本的函数均值趋近函数的数学期望。

所以，当时间足够长时（时刻大于某个正整数m)，在之后的时间（时刻小于等于某个正整数n，n＞m）里随机游走得到的样本集合$${X_{m+1},X_{m+2},X_{n}}$$就是目标概率分布的抽样结果，得到的函数均值（遍历均值） 就是要计算的数学期望值：$$\hat{E}=\frac{1}{n-m}\sum_{i=m+1}^{n}{f(x_i)}$$，到时刻m为止的时间段称为燃烧期。

构建具体的马尔可夫链：连续变量的时候，需要定义转移核函数；离散变量的时候，需要定义转移矩阵。一个方法是定义特殊的转移核函数或者转移矩阵，构建可逆马尔可夫链，这样可以保证遍历定理成立。常用的马尔可夫链蒙特卡罗法有Metropolis-Hastings算法、吉布斯（Gibbs）抽样。由于这个马尔可夫链满足遍历定理，随机游走的起始点并不影响得到的结果，即从不同的起始点出发，都会收敛到同一平稳分布。

马尔可夫链蒙特卡罗法的收敛性的判断通常是经验性的。比如，在马尔可夫链上进行随机游走，检验遍历均值是否收敛，具体地，每隔一段时间取一次样本，得到多个样本以后，计算遍历均值，当计算的均值稳定后，认为马尔可夫链已经收敛。再比如，在马尔可夫链上并行进行多个随机游走，比较各个随机游走的遍历均值是否接近一致。

马尔可夫链蒙特卡罗法中得到的样本序列，相邻的样本点是相关的，而不是独立的。因此，在需要独立样本时，可以在该样本序列中再次进行随机抽样比如每隔一段时间取一次样本，将这样得到的子样本集合作为独立样本集合。马尔可夫链蒙特卡罗法比接受-拒绝法更容易实现，因为只需要定义马尔可夫链， 而不需要定义建议分布。

### 马尔科夫链蒙特卡洛法与统计学习

马尔可夫链蒙特卡罗法为贝叶斯学习中的规范化（normalization）、边缘化（marginalization）和期望计算提供了一个通用的有效解决方案。

吉布斯抽样（Gibbs sampling）用于多元变量联合分布的抽样和估计，其基本做法是：从联合概率分布定义满条件概率分布，依次对满条件概率分布进行抽样，得到样本的序列。可以证明这样的抽样过程是在一个马尔可夫链上的随机游走，每一个样本对应着马尔可夫链的状态，平稳分布就是目标的联合分布。从而整体成为一个马尔可夫链蒙特卡罗法，燃烧期之后的样本就是联合分布的随机样本。

【具体算法实现不再在这里介绍，需要进一步了解】

## 9.2 Designing Monte Carlo simulation experiments

Monte Carlo simulation is named for the city in the principality of Monaco, famous for the roulette wheel, a simple random number generator. Monte Carlo method is a brute-force way of providing approximate solutions to a variety of mathematical problems by performing statistical sampling experiments with a computer using pseudo-random numbers.

The following steps are critical in designing an appropriate Monte Carlo experiment.

1. Properly specify the spatial statistical model of interest(e.g.,an auto-logistic model).
2. Determine what properties of the model need to vary(e.g.,sizeof geographic landscape, level of spatial autocorrelation); control for other sources of variation.
3. Select the set of population parameter values to study(e.g.,values commonly reported in the literature, error levels frequently encountered in practice, proper Type I and Type II error controls, controlling the degree of bias when model misspecification is of interest).
4. Perform checks based upon standard statistical theory to verify the trustworthiness of the simulated output (e.g., assume spatial autocorrelation is 0).
5. Execute a sufficient number of replications(e.g.,10,000)(to ensure the law of large numbers is operating and allow the summary statistics across the simulation experiment to exploit the central limit theeorem).

然后介绍了使用MCMC方法和逐步回归方法构造空间特征向量滤波的方法，这里不再介绍。

关于逐步回归：

逐步回归是一种线性回归模型自变量选择方法，前提是数据具有方差齐性、无异常值和正态分布的特点（检验方法），自变量间不存在多重共线性，其基本思想是将变量一个一个引入，引入的条件是其偏回归平方和经验是显著的。同时，每引入一个新变量后，对已入选回归模型的老变量逐个进行检验，将经检验认为不显著的变量删除，以保证所得自变量子集中每一个变量都是显著的。此过程经过若干步直到不能再引入新变量为止。这时回归模型中所有变量对因变量都是显著的。

## 9.3 Spatial error: a contributor to uncertainty

Arbia et al. suggest that principal sources of spatial error are random variable variation, location error, and interaction between the spatial autocorrelation in both of these sources of error. Griffith find that location error makes a difference, but moderate amounts still may result in parameter estimates falling with the correct confidence intervals. They also confirm that most location error for polygon-based geographic data is a displacement to adjacent polygons. These are contributors to uncertainty, or the margin of error of geographic measurements.

 Discussions especially in chapter 3 highlights samping error, in chapter 5 specification error, in chapter 7, prediction errors.

以下补充内容来自《地理信息系统空间分析原理》第7章“空间数据不确定性分析”

## 7.1 空间数据不确定性研究的内容

不确定性是指客观事物所表现出的模糊性，不稳定性不明确性，未知性以及不可知性。

早期人们将测量过程中测量值与真实值间的误差称为不确定性。误差是指统计意义上的偏差或错误，主要包括系统误差（测量过程中系统本身所固有的误差因素对测量造成的偏差）、随机误差（在同一条件下对同一被测量物的多次测量中以随机方式变化的误差）和粗差（操作过程中出现差错导致的误差，一般由主观因素引起，应当避免）。测量的结果可以用准确度来表示，准确度可以分为正确度（accuracy，与系统误差对应，指测量值与真实值之间接近的程度）和精密度（precision，与随机误差对应，指重复测量之间的一致性）。

“不确定性”的概念延伸：

+ 模糊性（外延的不确定，如各种地貌之间的过渡）
+ 不明确性（内涵的不确定，如黑土地定义）
+ 不稳定性（如电路中电压和电流强度的变化）
+ 未知性（如恐龙是怎样灭绝的）
+ 不可知性（如地层中某元素的实际含量）

空间上的不确定性：

+ 空间测量产生的误差和空间分析产生的误差：与位置有关的误差/与属性有关的误差
+ 空间实体蕴含的模糊性

空间不确定性的来源：

+ 客观本体的不确定性
+ 主观认知的局限性

或从空间数据过程的角度分为两类：

+ 数据获取过程中的量测误差
+ 数据分析过程中积累、产生和传递的不确定性

空间不确定性是衡量空间数据及其产品质量重要标准，对空间不确定性的充分认识，不仅有助于合理有效的使用空间数据及产品，而且还是进行空间决策的重要参考。

## 7.2 与空间数据不确定性研究相关的理论和方法

概率论、空间统计理论、证据数学理论（Dempster-Shafer理论，一套基于“证据”和“组合”来处理不确定性推理问题的数学方法）、模糊数学、粗糙集理论（主要研究对象的粗糙性，主要目的是从已有的数据中获得对概念的近似表示）、现代控制论...

## 7.3 空间数据不确定性模型

位置不确定性模型：以点元、线元、面元分析为基础，其中又以点元的不确定性分析为基础，点元的不确定性可以用误差椭圆进行描述，假定点位测量的随机误差服从二维正态分布，则对其不确定性的度量实质上就是其对应的误差椭圆与二维正态分布曲面围成的封闭体的体积。线元的不确定性分析以“$$\epsilon$$带”为基础，所谓的面元的不确定性实质上还是线元的不确定性。

属性的不确定性模型：混淆矩阵；基于概率的；基于Shannon信息熵的；基于粗糙集的。

## 7.4 空间数据不确定性的传递