# 传统四阶段法交通模型

## 前言

组内的交通氛围比较浓厚，四阶段法模型作为交通领域的经典模型在交通地理学中也有着广泛应用，抱着好奇的心态以同济大学的《交通工程》（吴娇蓉 等，2018年版）教材作为学习资料进行一下简单的学习。

毫无疑问交通工程的研究对象也是多尺度的，本书绪论便对其按照“交通特性”进行了三类划分：人的特性/车辆特性/交通流特性，描述如下：

+ 人的特性: 驾驶员和行人接收信息后的反应特性、生理特性心理特性和驾驶员的操纵特性。
+ 车辆特性: 包括车身长度、宽度高度动力性能(如加速减速制动等性能)。
+ 交通流(Traffic Flow)特性: 道路上机动车流的交通特征三要素（流量(Traffic Volume)、密度(Density)、速度(Speed/Velocity)）及车头时距(Time Headway)的变化规律各种不同条件下这些交通特征参数间的相互关系,以及行人流、非机动车流中空间、时间的变化规律等。

进而交通流理论、交通需求分析理论、交通规划等在交通工程的研究范畴之内。

第二章介绍了驾驶员特性和车辆特性，对驾驶员的视觉特性和反应特性进行了介绍，对车辆的服务要求、设计车辆概念（车的技术参数标准）、动力特性、制动特性、停车距离进行了介绍。

第三章介绍了机动车交通流特性，宏观交通流特征主要有交通流量（通过道路上一条车道或某一截面的车辆数）、流率（时间间隔内通过道路上一条车道或某一截面的当量小时交通量）、速度、密度（单位长度路段上，一个车道某一瞬时的车辆数）、车辆轨迹时空分布图，微观交通流指标主要有车头间距、车头时距。对于连续流的宏观特性，流量（q）、速度（u）、密度（k）是道路交通流的三个基本参数，被称为交通流三要素，20世纪30年代Greenshields对u-k关系的描述：

$$u=u_f(1-\frac{k}{k_j})$$

其中$$u_f$$是自由流车速，$$k_j$$是阻塞密度，则：

$$q=ku=u_fk-\frac{u_f}{k_j}k^2$$

要使交通流量最大，显然可以得到最佳密度$k_m=\frac{k_j}{2}$

间断流的特性、道路设施的通行能力与服务水平也在本章被介绍了，不同等级道路的通行能力C不同，实际交通量V与通行能力C的比值对应着不同的服务水平（一级~六级），等级越高表明交通流越不稳定。

第四章介绍了行人与非机动车的交通流特性。

第五章介绍了交通流理论，主要包括交通流相关的概率分布、排队论、车流波动理论和跟驰理论。

第六章从交通工程的角度介绍了交通网络，对道路网络、公共交通网络、步行与非机动车网络、轨道交通网络分别进行了介绍。

**第七章的章标题为“交通需求分析”，本部分主要对四阶段法过程和模型进行了介绍，所谓的四阶段（four-step），就是交通生成（traffic generation）、交通分布（traffic distribution）、交通模式划分（traffic modal split）、交通流量分配（traffic assignment），这也是本文档主要关注的内容。**

第八章为交通规划。

第九章为交通需求管理，从公共产品理论、市场失灵理论和政府管制理论出发，对可能调控交通需求的一些策略进行了介绍，可以从四阶段法的各个阶段的采取相应的措施，如TOD、拥堵收费等可以在交通产生与分布阶段对交通需求产生影响，公共交通优先则可以从交通方式选择与分配阶段产生影响。

第十章为道路交通安全。

第十一章为交通组织与设计，对交通设计原则以及道路横断面和交叉口进行了介绍。

第十二章为交通控制与管理，对交通信号控制与优化、干线控制、交通管理措施进行了介绍。

最后的第十三章介绍了交通工程的发展趋势，从交通工具、交通设施、交通组织模式三方面进行了介绍，其中提及的MaaS（Mobility as a Service）在当下已然普遍。

总的来说本书涵盖面非常广，对于了解交通研究的各个子类应该很有帮助，比较适合新手入门，以下是对四阶段法的学习，由于模型中的研究个体是人，所以这里将traffic替换为trip，强调人的出行。

## 相关概念

土地利用、交通运输条件、社会经济活动是交通需求分析的三要素。其中，社会经济活动依存于活动场所，这些场所用于城市有限空间内分散的、相互隔离的活动；交通运输条件指通过连接这些地点的网络设施以及提供这些地点的交通服务，实现人或物从一个地点到另一个地点的移动；交通需求和土地利用及可选择的交通条件之间具有促进与相互作用关系。

这段话对交通需求三要素进行了抽象的论述，但是仍然似乎不够抽象，如果是地理学者进行描述，想必对于“场所”“空间”之类的概念会进行更抽象的界定。

接着“可达性”“交通生成”“交通需求”三个概念作为专有名词被提出。

+ 本书认为可达性将土地利用格局和交通系统条件有效紧密地结合在了一起，前者代表了发展机会或服务设施等城市活动，后者代表了出行时间、出行距离等成本，如土地利用紧凑且交通运输条件好的地方被认为可达性好。这种accessibility的概念介绍是颇为简略的，毕竟地理学中与可达性相关的文章实在是很多，但与地理学领域常见的分类方法相比，这样的提法似乎更加抽象，其本质上对应的就是机会和成本。
+ 交通生成反映了某指定时段（通常为日/小时）内某某区域的交通量，认为交通生成量是土地利用的函数
+ 交通需求是由社会经济活动需要派生出来的，以实现生产或生活为目的，完成人或货物的空间移动，将城市或区域中每个人或每样货物在一定时间内的移动路径或位移在交通网络上叠加，即形成城市或区域的交通需求。

然后是一些评估客运交通需求特征的指标：出行/出行率/日出行总量；出行目的；交通方式结构；出行距离与时耗；出行时间及分布； 出行空间分布（OD矩阵/期望线图）；交通成本。

一些评估货物运输特征及需求特征的指标：货运（Logistics）的运输对象是被动的，货运需求可分为三类：生产原材料供应的运输/半成品、产成品的运输/生活服务业的货物流动，货物的上中下游组织、其与交通系统的匹配性也进行了简要讨论；货运需求描述指标主要有：货运量/货运周转量/运力结构；货运生成率；货运服务可达性；载运工具。

## 数据收集

书中认为需要四大类数据：

1. 土地利用数据：主要包括城市土地使用、用地规模、用地分布口及就业岗位分布等
2. 社会经济数据：主要包括城市概况、行政区划及人口、城市经济总量、产业结构与产业布局城市布局形态、建成区规模、城市社会经济发展规划、城市总体规划、控制性详细规划及相关专项规划、城市统计资料等
3. 居民出行数据：居民出行数据主要来源于居民出行调查(Oringin-Destinatioan Survey)。近年来也开始采集公交IC卡数据移动通信数据出租车GPS数据等作为补充。居民出行调查是了解居民出行特征最基本的调查也是建立交通需求预测模型的重要数据来源。通过调查,可以掌握全市居民的出行需求总量、出行需求在时间和空间上的分布,并可以分析归纳出交通需求产生的规律把握“源”与“流”之间的关系。出行调查数据通常包括住户特征个人特征交通工具拥有特征和出行特征四个部分。
4. 交通系统设施与运行数据：

   + 城市道路交通设施，含各级道路等级车道数通行能力现状及规划资料
   + 公共交通网络设施，含线路、站点、发车班次、车辆容量、票制、票价、运行管理模式等现状及规划资料
   + 枢纽场站、停车场布局功能、等级、规模等
   + 交通工具拥有量
   + 交通流量(路段、交叉口)、典型道路车速、典型道路交通延误等
   + 交通组织与管理

此外，本部分内容还介绍了居民出行调查特征数据的提取和基于连续性动态数据（如IC卡、GPS、手机信令等）的出行特征数据提取

## 交通需求分析模型

1962年美国芝加哥市交通规划研究中提出的“生成-分布-方式划分-分配”预测方法标志着“四阶段交通需求模型(Four-step Travel Demand Model)”的形成。该模型将每个人的出行按交通小区进行统计分析,从而得到以交通小区为单位的集计分析(Aggregate Analysis)模型。同时书中介绍，进入21世纪后活动模型被逐步整合成活动和出行行为仿真模型体系并与动态交通分配模型结合期望产生新一代交通需求分析模型体系来取代经典“四阶段交通需求模型”。然而,该体系目前仍处于研究阶段,尚未在实践中广泛应用。本节主要介绍经典的“四阶段交通需求分析”基本方法与基本技术。

Beckmann M. A continuous model of transportation[J]. Econometrica: Journal of the Econometric Society, 1952: 643-660.

### 1. Trip Generation

计算交通小区（TAZ）的交通需求总量。

四个主要概念：

+ 基家出行：O或D是出行者居所TAZ的出行
+ 非基家出行：O和D都不是出行者居所TAZ的出行
+ 出行产生量：基家出行中居所端点和非基于家的出行中起点的总数
+ 出行吸引量：基家出行中非居所端点和非基家出行中终点的总数

假如一个出行链：A->B->C->A，A是居所小区，则显然其中包含三次出行，两条基家出行，一条非基家出行。对于A，基家出行A->B和C->A其出现了两次，非基家出行B->C中其没有作为起点出现，所以其有2次出行产生量；A是居所端点，其出行吸引量为0。对于B，其是非居所端点，非基家出行中其作为起点出现了一次（B->C），其交通生成量为1；作为基家出行中的非居所端点出现了1次（A->B），作为非基家出行的终点出现了0次，因此其有1次出行生成量。对于C，其没有作为非基家出行的起点，因此其出行生成量为0次；同时其作为了1次基家出行中的非居所端点（C->A），作为了1次非基家出行中的终点（B->C），因此其有2次出行吸引量。

也就是基家出行的居所小区永远是出行产生小区，非居所小区永远是出行吸引小区，其他出行的起点小区作为出行产生小区，终点小区作为出行吸引小区。

如果对每次出行生成Production-Attraction矩阵，相加即可得到最终的总PA矩阵，总PA矩阵M可以做如下计算（行元素表示出行生成，列元素表示出行吸引，第0、1、2索引分别对应A、B、C）：

$$M = \left[\begin{matrix}0&1&0\\0&0&0\\0&0&0\end{matrix}\right] + \left[\begin{matrix}0&0&0\\0&0&1\\0&0&0\end{matrix}\right] + \left[\begin{matrix}0&0&1\\0&0&0\\0&0&0\end{matrix}\right] =\left[\begin{matrix}0&1&1\\0&0&1\\0&0&0\end{matrix}\right] $$

书中给出了两种计算出行产生（Production）量的模型：
（1）交叉分类模型，Cross Classified Model：TAZ中各类人群的出行率与各类人群的总人数相乘后再相加即可以得到TAZ的总出行产生量：

$$T_G=\sum_i{Tr_iP_i}$$

其中，$T_G$是总出行量，$Tr_i$是TAZ中第$i$类人群的出行率（从交通调查等数据中计算得到），$P_i$是TAZ中第$i$类人群的人口数量。

（2）线性回归：

$$Y=X\beta+\epsilon$$

其中，$Y$是个体的出行产生频率（出行率），$X$是解释变量，$\beta$是待求解的回归系数。如果计算得到的系数为$\hat\beta$，一个小区内有$m$个人，则一个TAZ的总出行产生量$P=\hat\beta\sum_{i=1}^m{x_i}=m\bar{X}\hat\beta$，此时$\bar{X}\hat\beta$就可以视作人均出行产生率

通常将出行进行分类（基家出行/非基家出行等），分别进行出行产生量的计算。

对于出行吸引量，计算也与出行生成量类似，但本书指出：

+ “在实践中预测小区的总吸引量一般采用在该小区内工作的人数或小区内的土地利用情况作为解释变量,置入线性回归模型中”
+ “出行吸引模型系数的估计可以利用两种不同来源的数据。一种数据来源是居民出行调查。在出行调查过程中,受访者提供了每次出行的起讫点位置和出行目的,因此可以判断这些出行吸引点所在的小区,然后统计调查样本中各个小区的吸引量。由于调查样本是从总体中随机抽样的，将从样本中获得的吸引量除以抽样率，即可估计小区的总吸引量，并将其视为线性回归模型中的因变量Y。而后采集小区内的解释变量，如各类就业人数、土地利用、人口等以构成解释变量矩阵X。注意，这里的Y向量和X矩阵中的每一行对应的是一个小区而不是一个个体出行者这类模型称为**集计模型**，而之前提到的出行产生率模型中的每一行代表一个个体出行者这类模型称为**非集计模型**。”
+ “另一种数据来源是位于出行吸引点调查,如工作地、购物商场、娱乐场所等地点的交通出行调查。调查过程中需要统计这些地点吸引的出行数量作为回归模型中的因变量，并记录该地点的吸引变量(如各类就业人数、商场或娱乐场所面积等)，作为解释变量。这类模型以每个吸引地点为预测单位，集计程度较低。”

显然，如果用以上流程分别计算出行产生量P和出行吸引量A，难以保证二者的总量相等。由于出行产生量的计算模型是非计集模型，所以一般使用出行产生量来校正出行吸引量，也就是所谓的出行平衡（Trip Balance）过程，对于编号为j的TAZ小区，调整后的出行吸引量$A_j$与计算得到的出行吸引量$A_j'$的关系是：

$$A_j=\frac{\sum_j{P_j}}{\sum_j{A_j'}}A_j'$$

同时指出：

+ 在“出行平衡过程”的最后环节，需要考虑非基家出行的产生端和吸引端的问题。假设$P_j$代表j小区由产生模型计算得到的非基家出行产生量，如果不考虑区内出行的情况，这$P_j$次非基家出行的起点(即产生点)并不在小区内，因此不能认为该小区是这些出行的起点(产生点)。在实践中,往往用$j$小区的非基家出行吸引量来确定该小区的非基家出行产生量，即令$P_j=A_j$。这种常用的定位方法是基于以下的考虑：对于非基家出行来说,其起讫点均不是出行者家的所在，出行者在一天的行程中仅途经这些点所在的小区，所以进入和离开该小区的非基家出行量基本上应该是相等的。
+ 这种方法在定位离家后的第一次和返家前的最后一次非基家出行时是有缺陷的。但由于非基家出行占总出行的比例较小，这些问题在实践中常被忽略。在非基家出行比例较高的情况下，应重视这些细节，可以考虑将这类非基家出行划分为单独的出行目的，分别进行预测平衡和调整。

### 2. Trip Distribution

通过交通生成过程可以得到PA矩阵$T$，$P$向量和$A$向量。已知现状出行分布，预测未来的出行分布。

增长系数法（Growth Factor Method）是一类常见的方法，可分为平均增长系数法：

$$T_{ij}'=T_{ij}\times\frac{G_i+G_j}{2}$$
$$G_i'=\alpha_i=\frac{P_iG_i}{P'_i}$$
$$\forall{i}, \alpha_i\epsilon[0.99, 1.01]$$

其中$$G_i$$、$$G_j$$是增长系数，$$ \alpha_i$$是调整系数，整个计算是一个迭代的过程。

Frater Method:

$$T_{ij}'=T_{ij}G_i G_j\frac{L_i+L_j}{2}$$
$$L_i=\frac{\sum_j{T_{ij}}}{\sum_j{T_{ij}{G_j}}}$$
$$G_i'=\alpha_i=\frac{P_iG_i}{P'_i}$$
$$\forall{i}, \alpha_i\epsilon[0.99, 1.01]$$

也是一个迭代的过程，其极大地依赖于增长系数。

重力模型也是一种常见的模型，该场景下的一般表达为：

$$T_{ij}'=KP_iA_jf(t_{ij})$$

其中，$K$是模型系数，$f(t_{ij})$是摩擦因子（friction factor），其是出行时间$t_{ij}$的减函数，如其Gamma函数的形式为$f(t_{ij})=\alpha t_{ij}^{\beta}e^{\gamma t_{ij}}$，其中$\alpha、\beta、\gamma$是待标定的参数。如果只需要保证$T'$中的总P或总A相等，则得到单约束重力模型：

$$K=\frac{1}{\sum_j{A_jf(t_{ij})}}$$

如果同时保证二者相等，则有：

$$T_{ij}'=R_iC_jP_iA_jf(t_{ij})$$
$$R_i=\frac{1}{\sum_j{C_jA_jf(t_{ij})}}$$
$$C_j=\frac{1}{\sum_i{R_iP_if(t_{ij})}}$$

这也是一个迭代的过程，需要保证系数$K$($R$和$C$)收敛。

### 3. Trip Modal Split

对出行需求矩阵按照不同的交通方式进行划分，得到不同交通方式的出行矩阵。

建模过程需要考虑的主要因素有：

+ 出行特征：交通目的、行程时间、交通费用、舒适程度、安全程度等，其中行程时间和交通费用是需要考虑的主要因素；
+ 个人及家庭特征：职业、性别、年龄、收入、支出、家庭成员数、住房形式、居住条件等；
+ 城市和区域特征：城市规模、居民规模、是否进入市中心、停放车辆的条件等；
+ 时段特征：不同时段的出行规律；
+ 交通方式特征：各种交通方式的车速、载客量、机动性、准时程度等。

两类常见模型：

1. Diversion Curve，转移曲线：出行者经济条件、出行目的、行时比、费用比和服务比，标定曲线后再对出行者特征进行计算即可；
2. Multinominal Logit Model，多元Logit模型：

$$
P_n(i)=\frac{e^{V_i}}{\sum_j{e^{V_{j}}}}\\
V_{i}=\beta X
$$

然后进行：

1. PA出行矩阵到OD矩阵的转换：
   + 基家出行：$TOD=\frac{TPA+TPA'}{2}$
   + 非基家出行：$TOD=TPA$
2. 分时段出行矩阵划分：使用转换系数矩阵（如早高峰、晚高峰、平峰期的基家和非基家的比例）进行直接分配。
3. 人出行与车出行之间的转换（如果有需要）。

### 4. Trip Assignment

道路交叉口通常是图的节点，路段是边；通常将TAZ质心视作出行的端点（产生源或吸引源）。

Wardrop在1952年提出网络均衡分配准则：

+ 第一准则（用户均衡，User Equilibrium）：出行者都确切知道网络的交通状态并选择最短路径出行，用户平衡状态下，所有出行者都不会通过单方面改变路径来降低其行程时间；
+ 第二准则（系统最优，System Optimum）：在系统最优状态下，网络总成本（或平均出行成本）最小。

1977年Daganzo和Sheffi的随机交通分配方法按照是否考虑拥堵效应和是否考虑出行者的感知误差，将交通分配模型分为4类。

||不考虑感知误差|考虑感知误差|
|:----:|:----:|:----:|
|不考虑拥堵效应|1.全有全无交通分配|2.随机交通分配|
|考虑拥堵效应|3.确定性用户均衡|4.随机用户均衡|

（1）全有全无（All or nothing）交通分配：OD对间的出行量全部分配到最短路径上，非最短路径的流量全部为0；
（2）随机交通分配：也成为多路径概率分配（Probabilistic Multi-route Assignment），OD对之间的感知阻抗等于实际阻抗和随机误差项之和，$C_k=c_k+\epsilon_k$，误差项服从相同的Gumble分布，则对于OD对之间的全部路径集合$K$，选择路径$k$的概率为：

$$P_k=\frac{e^{-\theta c_k}}{{\sum_{k\epsilon K}}{e^{-\theta k}}}$$

（3）用户均衡交通分配

Beckmann对UE准则的优化模型，目标函数是所有路段的时间成本之和，三个约束的含义分别是OD间各条路径的流量之和等于OD间的总流量，路段流量等于途径它的全部路径流量之和，路径流量非负：

$$
\min Z(x)=\sum_{a}{\int_0^{x_a}t_a(\omega)d\omega}\\
s.t.\sum_k{f_k^{rs}}=q_{rs}, (\forall,r\in R,s\in S)\\
x_a=\sum_r\sum_s\sum_k{f_k^{rs}\delta_{a,k}^{rs}}, (\forall a\in A)\\
f_k^{rs}\ge 0, (\forall r\in R, s\in S, k\in K^{rs})
$$
其中：

+ $x_a$：路段$a$上的流量
+ $t_a$：路段$a$的阻抗
+ $t_a(\omega)$：路段$a$的阻抗函数，是路段流量$\omega$的函数，如BPR函数：
$t_a(\omega)=t_0(1+\alpha(\frac{\omega}{c})^{\beta})$
  + 其中：
  + $t_a(\omega)$：路段$a$的流量为$\omega$时，路段$a$的行驶时间
  + $t_0$$：自由流状态下，路段$a$的行驶时间
  + $c$：路段$$a$$的通行能力
  + $\alpha,\beta$：参数，通常分别取$0.15$和$0.4$
+ $f_k^{rs}$：OD对$(r,s)$间第$k$条路径的流量
+ $q_{rs}$：OD对$(r,s)$间的总流量
+ $\delta_{a,k}^{rs}$：路段-路径关联变量，若路段$a$在OD对$(r,s)$间的第$k$条路径上，则取1，否则取0
+ $A$: 网络中路段的集合
+ $R$: 网络中起点的集合
+ $S$: 网络中终点的集合

可以证明最优（用户均衡）时：

+ 所有使用路径的阻抗相等且最小
+ 未被使用路径的阻抗不小于使用路径的阻抗

由此得到Frank-Wolfe算法：

1. $t_a^{0}=t_a(0), \forall a$，进行全有全无分配，得到各路段流量${x_a^1},n=1$
2. 更新各路段阻抗：$t_a^n=t_a(x_a^n), \forall a$
3. 寻找迭代方向：按照更新后的${t_a^n}$，进行全有全无分配，得到附加流量${y_a^n}$
4. 确定迭代步长：求解满足如下问题的最优$\lambda$：$\min_{0\le\lambda\le1}{\sum_a{\int_0^{x_a^n+\lambda(y_a^n-x_a^n)}t_a(\omega)d\omega}}$
5. 确定新的迭代点：$x_a^{n+1}=x_a^n+\lambda(y_a^n-x_a^n)$
6. 收敛性检验：若${x_a^{n+1}}$满足收敛准则（如$\frac{\sqrt{\sum_a{(x_a^{n+1}-x_a^n)^2}}}{\sum_a{x_a^n}}<10^{-4}$），则停止计算，${x_a^{n+1}}$为最优解，否则令$n=n+1$，返回第二步。

（4）随机均衡用户分配：同时考虑感知误差。
（5）系统最优用户均衡：目标函数修改为所有路段的车辆（或其他对象）的总时间成本：
$\min Z(x)=\sum_a{x_at_a(x_a)}=\sum_{a}{\int_0^{x_a}(t_a(x_a)+x_a\frac{dt_a}{dx_a})dx_a}$

$t_a(x_a)+x_a\frac{dt_a}{dx_a})$表示路段的边际行程时间，达到最优时会满足各路径的边际行程时间相等。

本书对UE和SO两种状态的评价是：“在系统最优状态下，如果路段1上的一些出行者为了减少出行时间而转移到比较快的路段2上，系统最优的状态将无法维持。由于出行者趋于利已的选择行为机制，在不加干预的情况下，系统将不可避免地转向用户均衡的状态。”

至此，本书对四阶段交通需求模型的介绍全部结束。

### 小结

|阶段|概述|相关模型|
|:----:|:----:|:----:|
|trip generation|出行生成，根据出行数据统计各TAZ到各TAZ的交通量，通常对基家出行和非基家出行分别进行生成，使用计集模型或非计集模型进行计算，最后通常需要进行出行平衡，以保证TAZ的出行产生和出行吸引量相等|交叉分类模型，线性回归|
|trip distribution|出行分配，根据现状PA矩阵进行流量的重新分配|增长系数法（包括Fratar法），重力模型|
|trip modal split|出行方式划分，将总出行矩阵分解为各个出行方式矩阵的和|多元Logit模型|
|trip assignment|根据OD矩阵将OD间的流量分配到路网上|用户均衡法，系统最优法|

### Python代码
