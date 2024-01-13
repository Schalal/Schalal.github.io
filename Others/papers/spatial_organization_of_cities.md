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
### 城市科学研究方法概览
### How many parameters?
### 城市经济学基本准则
### 数据
### 跨学科研究的障碍

## The Spatial Organization of Cities
### Optimal location
### Measuring a polycentric structure
### Fujita-Ogawa model
### The edge-city model