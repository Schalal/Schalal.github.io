
- [The spatial orgnization of cities](#the-spatial-orgnization-of-cities)
  - [Urban Systems](#urban-systems)
    - [关于城市科学](#关于城市科学)
    - [关于城市的定义](#关于城市的定义)
    - [从时空间尺度看待城市](#从时空间尺度看待城市)
  - [模型和方法](#模型和方法)
    - [复杂系统的统计物理学](#复杂系统的统计物理学)
    - [The shape of a science of cities](#the-shape-of-a-science-of-cities)
    - [How many parameters?](#how-many-parameters)
    - [城市经济学基本准则](#城市经济学基本准则)
      - [交互和均衡（Interactions and equilibrium）](#交互和均衡interactions-and-equilibrium)
      - [效用选择的不变性（Invariance with respect to utility choice）](#效用选择的不变性invariance-with-respect-to-utility-choice)
    - [数据](#数据)
    - [跨学科研究的障碍](#跨学科研究的障碍)
  - [The Spatial Organization of Cities](#the-spatial-organization-of-cities)
    - [Optimal location](#optimal-location)
      - [公用设施的空间分布](#公用设施的空间分布)
      - [零售商店的空间分布](#零售商店的空间分布)
    - [Measuring a polycentric structure](#measuring-a-polycentric-structure)
    - [Fujita-Ogawa model](#fujita-ogawa-model)
    - [The edge-city model](#the-edge-city-model)

# The spatial orgnization of cities

内容参考自Marc Barthelemy《The Structures and Dynamics of Cities —— Urban Data Analysis and Theoretical Modeling》，本书结合了统计物理学和城市经济学的理论，提供了对城市和城市系统的跨学科和现代的研究视角，经典的实证和理论模型在本书中得到评述。

## Urban Systems

### 关于城市科学

计量地理学/城市经济学的高度抽象模型/复杂参数模拟城市演变-->统计物理学+空间经济学+计量地理学--对城市研究的跨学科视角

首要目标是理解城市这一对象，识别塑造和演进城市的首要因素。

*The goal of a science of cities will be reached when, considering a specific case,
we can basically say what will happen and which ingredients it is necessary to
introduce in a model in order to get more detailed information and predictions.*

*Here, understanding means that we can construct a consistent story, based on a few ingredients, that explains a selection of facts observed in reality.*

*Indeed, we would like to assess quantitatively the impact of various factors, which means that we want to write mathematical relations between different quantities.*

*The main point here is to identify the most important parameters, not only to understand the past, but also to be able to construct a model that indicates with reasonable confidence the future evolution of a city and allows the impact of various policies to be tested.*

### 关于城市的定义

*cities exist in order to connect people.*

一些核心要素：个体交互（individual interact）、交通、政策等等

如何定义一个城市仍是问题：根据行政区定义虽然直接但已经outdated，无法捕捉城市蔓延现象，于是基于城市中心和连接中心的通勤率（commuter fraction）等参数对城市进行定义，或使用连片建成区这样的non-ambiguous对象进行定义（如使用City Clustering Algorithm进行自下而上的城市识别。）

### 从时空间尺度看待城市

不同时间尺度和空间尺度研究的城市问题是不同的，但这些尺度经常混合在一起，使得从均衡角度考虑城市问题和单独考虑某个问题是困难的。承认不同的过程彼此相关联，以上论述成为城市建模的关键问题，研究时考虑时空间尺度也成为必要。*This almost continuous spectrum makes it difficult to consider cities as being in equilibrium but also to view these processes as decoupled from each other. This is a very important problem in city modeling and necessitates a careful discussion of spatial and temporal scales, acknowledging the possibility that various processes are interfering with each other.*

以下聚焦一些特定变量进行分析：

+ Population($P$)：Indeed, it is often assumed to be the explanatory varibale, neglecting endogeneity issues. 与人口数量相关的城市议题有很多：城市规模（绝对人口数量，不同数量城市占比等）/增长率（发达国家与发展中国家增长模式/原因的差异等）/人口数量分布和Zipf's Law
+ Area($A$):使用$L=\sqrt{A}$,来衡量城市大小，并检验是否符合Zipf's Law；Density:一般指人口密度，$\rho=\frac{P}{A}, \rho(x)=\frac{P(x)}{A(x)}$；Volume of Cities:考虑建筑高度，如从高度、面积和体积三个方向研究建筑的人口数量的分布情况（指数拟合，观察指数的大小），研究平均建筑高度人口数量的关系。
+ 时间尺度：如daily尺度可以研究通勤行为，更大的尺度可以研究人口出生和移民带来的城市增长
+ Naive Scaling，将面积、路网总长度、日通勤距离和人口数量的关系进行简单的建模介绍：
  + 面积，如果假定人口密度不变，则有$A \sim \lambda ^2P$，人均面积$\lambda ^2$是一个常数。但显然城市面积的扩张是有限的，它们的增长量不可能总是线性关系，通过实证研究可以获得人口密度和人口数量之间的关系$\rho \sim P^{1-\alpha}, 0<\alpha<1$，城市人口数量越大，其人口密度增长越缓慢。
  + 路网总长度：路段长度$l_R\sim\sqrt{\frac{A}{N}}$，$N$是交叉口数量，人口数与交叉口数量成正比，于是$l_R\sim\sqrt{\frac{A}{P}}$，于是道路总长度$L_N\sim Pl_R$，于是$L_N\sim P$。
  + 日通勤总距离：假设理想的职住地关系是确定的，则总通勤距离与城市大小无关，则有$\frac{L_{tot}}{P}\sim const$，添加约束：单中心的就业中心，则$\frac{L_{tot}^{mono}}{\sqrt{A}}\sim P$，如果完全没有中心化，则$\frac{L_{tot}^{mono}}{\sqrt{A}}\sim \sqrt{P}$，如果有$k$个面积为$A_1$的均质中心，则$A=kA_1,L_{tot}\sim k\times \frac{P}{k}\sqrt{A_1}\sim P\sqrt{\frac{A}{k}}$，如果假设中心数量和人口数有幂律关系$k\sim P^{\alpha}$，有$\frac{L_{tot}}{\sqrt{A}}\sim P^{1-\frac{\alpha}{2}}$，有实证研究计算对于美国城市而言，$\alpha \approx 0.8$。

*We see from this discussion that important information about the structure of cities and mobility patterns can be encoded in the nontrivial values of exponents characterizing the evolution of macroscopic quantities such as area, total commuting distance, and so on. In this respect, this kind of macroscopic measure can then serve as a guide for finding the correct theoretical model.*

## 模型和方法

### 复杂系统的统计物理学

statistical physics: 可以追溯到19实际的热力学（thermodynamics）研究，建立起了微观描述和宏观观察之间的联系。

相转换——一种涌现行为（emergent behavior）：is not easily predictable from the properties of elementary constituents. 涌现行为由个体交互产生，即使这种交互是简单的。 In addition, the emergent behavior depends not on all the details describing the system, but rather on a small number of parameters that are actually relevant at large scales.

A city is an emergent phenomenon resulting from agents interacting with each other. 研究城市问题转变为研究可以解释城市中涌现行为的个体交互和微观动机的组分的识别问题。

本书的视角是以generic aspect来研究城市的，不局限于各个城市的历史以及区位，试图发现城市的普遍规律。 Devoting to a specific area is however, less relevant to the task of finding dominant mechanisms and parameters that govern city evolution. At the root of this is the brief that all cities are various expressions of the same object.

### The shape of a science of cities

不同的问题需要在对应的尺度下进行求解：研究水流不应该从分子尺度下进行，而应该从宏观上使用Navier-Strokes方程求解。Each problem has its own scale and a set of principles. And its level might require a whole new conceptual structure.

物理学对系统认知的准则：Physics is not a catalogue of disparate models, but rather a small set of mechanisms which once applied to a particular system, have great predictive power.  Very roughly in physics. When we say that we understand the system, it usually means that:

1. We know the dominant mechanisms.
2. We are able to construct a minimal model with predictions, constant with empirical observations and measures.
3. We can propose new experiments and applications and how to modify the system in order to improve it.

In particular, from 1, we can predict the response of the system when we apply a perturbation to try to modify it. In the case of cities, we could thus offer some general large scale insights when facing different planning alternatives. Understanding the main forces and being able to predict the effect of various changes in an urban system would thus be an important goal for a science of cities.

### How many parameters?

统计物理学的首要关注点就是对系统的微观描述和以少量参数描述系统的宏观行为。如用温度来描述相转换。

The idea that only a few parameters are actually relevant for describing the macroscopic behavior is probably the one that will prove most useful across other disciplines.

对于城市建模存在着两种流派：

+ 城市经济学以很少的参数进行建模，但通常与实证数据联系较弱。与真实世界的联系通常是通过典型化事实（stylized facts），预测及与实证数据进行定量化对比相对缺乏。
+ 基于agent的模拟通常需要很多的参数详细描述城市之间各种变量之间的关系，如土地-交通集成模型（landuse-transport integrated model, LUTIM）就是一种典型的此类模型。对数据的拟合程度较好，但其有效性难以验证，且当系统发生非轻微（non-negligible）的、未预期的扰动的时候我们对其预测结果的信心也是难以清晰说明的。

在一般的复杂系统中参数的量同样有着类似的问题：

+ 大量的参数可能包含冗余参数，需要对其进行综合消除冗余；
+ 复现现象如果需要微调参数可能暗示着缺乏对某些动态机理的揭示。

在物理学中，通常认为有着较小参数量且较大预测结果数的模型是一个好的模型。近些年来城市数据的可获取性的急剧提高为在城市研究中建立这样一个minimal model提供了可能性，但前提是能够对城市演进的多层机理有清晰的认知。

物理学家通常先以最少量的参数提出模型，然后通过实证观察来校核模型，通过添加参数或提出新的机理来修正模型，但这种方式在LUTI类模型中是不适用的。原因是这类模型中的参数量过于巨大，以至于难以评估各个参数之间的相关性，有如此多参数的模型基本可以视作黑箱（black box）模型，以至于其对现实现象的不错效果与其说是解释，不如说是过拟合。

此外，物理学家构建模型不依恋于（never clung to）预先存在的工具，而是通过现象来调整数学工具。但在城市经济学中，源自优化理论和近些年来交通优化理论的数学工具可能反而成为他们对现实描述的适应的障碍。如McCall的job search理论就是一个例子。

【笔者评价：话很刻薄。】

### 城市经济学基本准则

传统城市经济学模型的不足：

1. 直接假设城市的空间结构是单中心的（monocentric）
2. 所有模型都假设城市处于均衡状态（in equilibrium）。这里主要从时间尺度的差异性对城市的均衡状态进行了讨论，即在不同的时间尺度内城市的均衡状态至少是会变化的甚至假定均衡完全与事实不符。此外，已有研究讨论了城市动态是间歇性的，在相对较短的时间内爆发活动的可能性。
3. 城市问题通常有路径依赖型（path dependence），即一种城市现象通常是多个时间尺度叠加的结果（superpimposition），城市经济学通常不考虑这种irreversibility，即所有个体都必须同时处理一些事务并且不能从头开始。
4. 这些模型通常只能提供理论指导，由于实证结果的缺乏不能使用数据来验证。此类问题不仅在于模型本身对问题的简化，还在于我们有多大信息信任这些模型及其与事实的关联。通过数据进行的模型验证通常有问题，通常不会直接测试模型的预测，而只能通过统计手段进行测试。

接下来对上述四点进行更详细的讨论，包括均衡状态假设以及效用函数的选择问题。

#### 交互和均衡（Interactions and equilibrium）

组分的相关性在城市经济学研究中常常被忽视，虽然在计量社会学中这种考虑早已存在（Schelling, 1971），但是大多数城市经济学理论只考虑一种典型的agent，即无需考虑其他agent的行为，只考虑自身效用的最大化。

*A crucial assumption in urban economics is that of equilibrium, which is somehow surprising.*

+ 均衡状态下对时间尺度的假定：$\tau_{evol}>>\tau_{obs}$，即城市变化的时间尺度远大于典型化观察的尺度
+ 但真实情况是the coexistence of a large number of processes and agents，小时间尺度和大时间尺度在城市中是共存的，如人口数量也会随着各种时间尺度发生变化

#### 效用选择的不变性（Invariance with respect to utility choice）

城市经济学中另一个重要的问题是效用函数的选择问题。这里首先介绍一个不依赖效用函数的good case，再介绍一个依赖效用函数的special case.

*A good case: the bid-rent gradient.*

城市地租模型的经典模型：Alonso-Muth-Mills模型。模型假定城市单中心单出行方式，在区位$x$处租房面积为$s(x)$的预算约束为：

$$Y=z+C_R(x)+T(x)$$

其中$Y$是收入，$C_R(x)$和$T(x)$是区位的租金成本和交通成本，$z$代表其他成本（composite commodities）。假设单位面积的租金$R(x)$依赖区位$x$，$C_R(x)=R(x)s(x)$。假设交通成本只与距区位中心的距离有关，$T(x)=V|x|/v$，其中$V$为单位时间成本，$v$为交通模式的平均速度。城市经济学中，标准假设是优化效用最大化，效用函数只与$s$和$z$有关：

$U=U(z,s)$

使用拉格朗日乘子法进行求解，等价于：

$$\max_{z,s}(U(z,s)-\lambda(Y-z-C_R-T))$$

也可以将约束引入效用函数中，即最大化$U(Y-R(x)s-T(x),s)$即可，令$\frac{d U}{d s}=0$，得到：

$$\partial_1 U(-R(x))+\partial_2 U=0$$

$$R(x)=\frac{\partial_2 U}{\partial_1 U}$$

$\frac{d U}{d x}=0$，得到：

$$
\partial_1U(-s\frac{dR}{dx}-R\frac{ds}{dx}-\frac{V}{v})+\partial_2U\frac{\partial s}{\partial x}=0\\
-s\frac{dR}{dx}-\frac{V}{v}=0\\
\frac{d R}{d x}=-\frac{V}{vs(x)}
$$

上述得到的$\frac{d R}{d x}=-\frac{V}{vs(x)}$在任意效用函数下都适用，表明单位租金和区位的关系是减函数，人需要在交通成本和租金之间做权衡。

*problem arise: solving the problem.*

想要完全求解该模型，需要给出特定的效用函数，如何给？如可以写为：

$$U(z,s)=\alpha\log z+\beta\log s\\
\alpha + \beta = 1\\
Y=e^{\frac{u}{\alpha}}s^{-\frac{\beta}{\alpha}}+sR(x)+T(x)\\
...$$

*This is obviously a crucial question since the utility formalization is a pillar of urban economics, but unless we can bring empirical evidence to support it, it's scientific validity can be challenged.*

### 数据

The crucial game changer in research on cities is data.

从小时间尺度到大时间尺度，手机信令数据，社会经济数据，历史数据都是城市研究中的数据吗，对应不同的研究问题。

+ 数据源：数据本身可获取性的增加；期刊研究的数据可获取性增加；由于对城市的定义不同，数据的一致性和协调性问题成为城市研究的问题
+ 不同类型的数据：网络数据；地理历史数据；移动性数据；社会经济数据
+ Data are not enough. 模型（model），数据（data）和经验观察（empirical observation）缺一不可，缺失则对结果的解释将存在问题。没有经验验证则城市模型对应的理论将不甚清晰，没有理论框架则经验度量可能存在误导性。对于后者，本书以$CO_2$排放量和人口规模的指数关系模型为例进行了阐述：

$$
Q_{CO_2}=P^{\beta}
$$

如果没有正确的理论框架，则常见两类错误：

1. 交通碳排量的计算：以通勤距离作为简介度量量是错误的，因为拥堵的存在，使用通勤时长进行度量则更加合理；
2. 城市定义的问题：计集模型在不同的城市定义下产生了不同的$\beta$参数估值（0.95/1.37）,从而得出了相反的结论。This is related to the more important problem: the absence of any mechanistic insights about this scaling.

This example clearly illustrates the dangers of interpreting data without a theoretical guide and in the absence of the feedback loop between theory and data.

### 跨学科研究的障碍

不同研究领域的专门化对于理解城市是无益的，有时甚至会造成误解及沟通艰难。障碍主要体现在：

1. 一个领域的quantity对于另一个领域可能是不足的，如定性研究的社会科学家觉得研究城市只需要很少的数据，但这在定量研究视角下是远远不够的。The current tension between urbanism and quantitative approaches cries out for a dialog.
2. 城市经济学对研究问题的简化和物理学家的分析视角有分歧。
3. 学科迁移会存在问题：the possibility of counterproductive arrogance, a lack of knowledge of the existing literature, the danger of reinventing the wheel, the use of authority arguments for rejecting a result obtained by an outsider.

对此，作者呼吁：*The outsider should definitely know the subject and the literature of the domain, but experts in that domain should not reject the outsider too hastily, and should consider the results on a purely scientific basis.*

## The Spatial Organization of Cities

The locations of homes, activities, and businesses shape a city, and identifying the mechanisms that govern these spatial distributions is crucial for our understanding of these systems.

### Optimal location

#### 公用设施的空间分布

如机场、邮局、医院等公用设施依据局部的人口密度在空间上进行分布从而优化其效率。这些设施组成了城市结构的重要部分且帮助塑造人口的空间分布。区域$D$内，以$\rho (x)$表示位置$x$处的人口密度，N个公用设施的位置为$\{x_1,x_2,...x_N\}$，则以如下自然的考虑作为优化目标（人口到各个公用设施的最小距离之和最小）：

$$
F(x_1,x_2,...,x_N)=\int{\rho(x)\min|x-x_i|}dx
$$

考虑使用各个设施点的Voronoi图替代上式中的最小距离，对于$x$处，其所在的设施点Voronoi cell面积如果为$a(x)$，则其到各设施点的最小距离为到所在Voronoi cell源点的距离与$g\sqrt{a(x)}$成正比，where g is a geometrical factor of order 1 that depends on the shape of the Voronoi cell.【todo: 有待学习geometrical factor of order 1的概念】

则优化目标可以表示为：

$$
F(a(x))\sim \int \rho(x)\sqrt{a(x)}d^2 x\\
s.t. \int_D \frac{1}{a(x)}d^2 x = N
$$

【？】

使用拉格朗日乘子法进行求解，令：

$$
\frac{\partial}{\partial{a(x)}}[\int \rho(x)\sqrt{a(x)}d^2 x+\lambda(\int_D \frac{1}{a(x)}d^2 x - N)]=0
$$

得到：

$$
\frac{\rho(x)}{\sqrt{a(x)}}=\frac{2\lambda}{a(x)^2}\\
a(x)\sim(\frac{\lambda}{{\rho(x)}})^{\frac{2}{3}}
$$

得到设施的密度：

$$
\rho_f(x)=\frac{1}{a(x)}=\frac{N}{\int \rho(x)^{\frac{2}{3}}}\rho(x)^{\frac{2}{3}}
$$

得到Voronoi cell面积、平均半径、其中人口数的关系：

$$
a(x)\sim \rho(x)^{-\frac{2}{3}}\\
r(x)\sim \rho(x)^{-\frac{1}{3}}\\
n(x)\sim \rho(x)a(x) \sim \rho(x)^{\frac{1}{3}}
$$

可以根据上述理论对公用设施的空间分布的合理程度进行简单评估。

#### 零售商店的空间分布

不同类型的商店间可能会吸引或排斥彼此，这种交互作用决定了商店的空间分布。假设一个城市中有两类商店A和B，其数量分别为$N_A$和$N_B$，总数为$N_{tot}$，则位置$x$处的A类型商店的$M$指数定义为：

$$M_{AB}(x,r)=\frac{n_B(x,r)/n_{tot}(x,r)}{N_B/N_{tot}}$$

其中$n_B(x,r),n_{tot}(x,r)$分别表示$x$处B类型商店的数量和商店的总数量，该指数计算了局部密度和全局密度的比值，如果M指数远大于1，则说明$x$处A和B的吸引作用更明显。分子中的分母也可以表示为$n_{tot}(x,r)-n_A(x,r)$，将局部的A商店间的吸引也考虑在内。基于上述局部指数可以计算得到全局的局部指数平均值$M_{AB}(r)$，其方差也包含有用的信息。

令$a_{AB}=\log M_{AB}$，使用$i$表示商店的可能区位，$\sigma_i$表示商店类别，$\pi_{\sigma_i\sigma_j}=1 \quad\text{if}\quad \sigma_i == \sigma_j\quad\text{else} -1$，则可定义如下目标函数：

$$
K=\sum_{i,j}a_{\sigma_i\sigma_j}\pi_{\sigma_i\sigma_j}
$$

定义$x$处的环境质量，$n_{ij}(x)$是$x$处类型为$i$的商店邻域内的$j$类型商店的数量，A large index thus corresponds to an environment in which the “favorite” neighbors of i are over-represented.

$$
Q_i(x)=\sum_{j}{a_{ij}(n_{ij}(x)-\bar{n_{ij}})}
$$

### Measuring a polycentric structure

定义：中心——热点，

识别和计量热点的非参数方法：
1. 计算均值$m=\bar{\rho(i)}$
2. 计算洛伦兹曲线y值：$L(i)=\frac{\sum_{j=1}^{i}\rho(j)}{\sum_{j=1}^{n}\rho(j)},\rho(1)<\rho(2)<...<\rho(n)$

### Fujita-Ogawa model
### The edge-city model