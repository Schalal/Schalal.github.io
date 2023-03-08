# 02 认识数据

## 2.1 数据对象与属性数据

+ 一个数据对象代表一个实体；
+ 属性是一个数据字段，代表数据对象的一个特征。

四种量表：nominal, ordinal, numeric, ratio

## 2.2 基本统计描述

+ 中心趋势度量：均值、中位数、众数
+ 离散趋势度量：极差、四分位数、方差、标准差、四分位数极差；
  + 五数概括——Min, Q1, Median, Q3, Max
  + 盒图——五数概括+1.5IQR之外的离群点
+ 图形描述
  + 分位数图
  + 分位数-分位数图（QQ图）
  + 直方图
  + 散点图

（《空间数据分析》对应章节内容与本部分内容完全一致）

## 2.3 数据可视化

+ 基于像素的可视化技术：一个m维的数据集对应屏幕上的m个窗口，一个数据对象各维度像素在各自窗口中对应的位置相同；
+ 集合投影可视化技术：将多维属性转换到低维空间中表示，如散点图、散点图矩阵、平行坐标（parallel coordinates，即绘制n个等距离、相互平行的轴，数据记录用折线表示，与每个轴在对应相关维值的点相交，对于大数据集不适用）；
+ 基于图幅（Icon-Based）的可视化技术：使用icon表示多维数据值，典型代表：Chernoff Faces，Stick Figure；
+ 层次可视化技术：将高维数据在低维子空间中表示（某些维度取固定值），典型代表：Worlds-within-Worlds，tree-map；
+ 可视化复杂对象和关系：主要针对非数值数据，如词云图，社交关系图。

## 2.4 度量数据的相似性和相异性

一些概念：

+ 簇：数据对象的集合，簇内的对象相似（similar）并于其他簇中的数据相异（dissimilar）；
+ 相似性（similarity）和相异性（dissimilarity）统称为邻近性（proximity），因为二者是辩证统一的；
+ 数据矩阵（Data Matrix）,即对象-属性结构（Object-Attribute Structure），表达对象集属性数据的矩阵；
+ 相异性矩阵（Dissimilarity Matrix），即对象-对象结构（Object-by-Object Matrix），矩阵元素值是数据对象间的邻近性度量值，空间统计学中的“距离矩阵”与其形式一致。

各类数据的邻近度度量方式：

|数据类型|数据邻近度度量方式|参数说明|
|:----:|:----:|:----:|
|nominal|$d(i,j)=\frac{p-m}{p}$|$m$是名义属性值一致的属性数目，$p$是属性总数目|
|bool|$d(i,j)=\frac{r+s}{q+r+s}$|bool属性即取值只能为0或1的属性，q表示对象i和对象j属性均为1数目，r表示在对象i中取值为1而在对象j中取值为0的属性数目，s表示在对象i中取值为0而在对象j中取值为1的属性数目，t表示在对象i和对象j中取值都为0的属性数目（常常被忽略），$sim(i,j)=1-d(i,j)$常被称作Jaccard系数|
|numeric|Minkowski Distance等各种形式的距离表达||
|ordinal|先次序数值化$z_{if}=\frac{r_{if}-1}{M_f-1}$，再针对$z_{if}$的距离度量|这只是一种数值化次序的一种方式，数值化后的值域为\[0,1\],$r_{if}\in\{1,2,3,...,M_f\}$，即对象i某次序属性的次序|
|混合距离|$d(i,j)=\frac{\sum_{f=1}^{p}{\delta_{ij}^{(f)}d_{ij}^{(f)}}}{\sum_{f=1}^{p}{\delta_{ij}^{(f)}}}$|如果对象i或对象j某一属性值缺失，则$\delta_{ij}^{f}=0$，否则$\delta_{ij}^{f}=1$，$d_{ij}^{f}就是对象属性的对应距离$|

+ Cosine Similarity

常用来衡量类似于词频向量（term-frequency vector）这样的数据的相似度，衡量的向量通常有很多个维度而且是稀疏的（有许多0值）。

$sim(\vec{x},\vec{y})=\frac{\vec{x}\cdot\vec{y}}{|\vec{x}||\vec{y}|}=cos<\vec{x},\vec{y}>$

当属性是二值属性时，如果$x_i=1$，则称对象$x$具有第i个属性，此时$\vec{x}\cdot\vec{y}$表示对象$x$和对象$y$共同具有的属性数，则余弦相似度的一个常用变体为：

$sim(\vec{x},\vec{y})=\frac{\vec{x}\cdot\vec{y}}{\vec{x}\cdot\vec{x}+\vec{y}\cdot\vec{y}-\vec{x}\cdot\vec{y}}$

即交集属性个数和并集属性个数的比例，称为Tanimono系数。
