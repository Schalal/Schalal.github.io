# 01 引论

## 1.1 Why Data Mining?

+ 信息时代，数据挖掘讲数据集转换成知识，eg: Google的流感医生（Flu Trends）
+ 数据挖掘是信息技术的进化，可以帮助将数据转化为信息
  + 20世纪60年代：数据收集和数据库创建
  + 20世纪70年代~80年代初期：数据库管理系统
  + 20世纪80年代中期至今：高级数据库系统（eg：高级数据模型，基于Web的数据库，云计算，分布式计算，数据安全）；20世纪80年代后期至今：高级数据分析（eg：数据仓库，数据挖掘）
  + 未来一代信息系统

## 1.2 What is Data Mining?

Data Mining = Knowledge Discovery from Data = KDD

(Data Mining is the process of discovering interesting patterns and knowledge from large amounts of data)

KDD的步骤：

+ 数据请理（Data Cleaing）：消除噪声和删除不一致的数据
+ 数据集成（Data Intergration）：组合多种数据源
+ 数据选择（Data Selection）：从数据库中提取与任务相关的数据
+ 数据变换（Data Transformation）：通过汇总或聚集操作，把数据变换和统一成适合挖掘的形式
+ 数据挖掘（Data Mining）：使用某种方法提取数据模式
+ 模式评估（Pattern Evaluation）：根据某种兴趣度度量，识别代表知识的模式
+ 知识表达（Knowledge Presentation）：使用可视化技术向用户呈现挖掘结果

## 1.3 What kinds of data can be mined?

### 1.3.1 数据库数据（主要还是关系数据库）

一些名词：

+ DBMS：Database Management System = 内部相关的数据（数据库）+管理和存取数据的软件程序
+ attribute：也就是字段，数据表的一列，也称field、column
+ tuple：也就是元组，数据表的一行，也称record、row，对象必须有唯一的标识符，对应的字段称为主键字段
+ E-R Model：即Entity-Relation model，对象-关系模型
+ 关系数据库：基于关系的数据库，通常直接由多张表组成
+ Query：即查询，通过查询即可实现对数据库数据的访问
+ SQL: Structured Query Language

### 1.3.2 数据仓库（Data Warehouses）

A data warehouse is a repository of information collected from multiple sources, stored under a unified schema, and usually residing at a single site. Data warehouses are constructed via a process of data cleaning, data integration, data transformation, data loading, and peri- odic data refreshing.

A Data warehouse is uaually modeled by a multidimensional data structure, called a data cube, in which each dimension corresponds to an attribute in the schema, and each cell stores the value of some aggregate measure. A data cube provides a multidimensional view of data and allows the precomputation and fast access of summarized data.

OLAP: Online Analytical Process

Examples of OLAP Operations: drill-down and roll-up.

这里，所谓的下钻和上卷，也就是降尺度和升尺度的概念，所谓的数据仓库，也就是数据的多维多尺度存储形式。

### 1.3.3 事务数据（Transaction Data）

A transaction typically includes a unique transaction identity number and a list of the items making up the trasaction.

eg: 一次购买记录中有a、b、c、d这四种物品，则a、b、c、d分别是一个item，他们构成了这次购买的这一个transaction

事务数据可以在关系数据库中表达

### 1.3.4 其他数据

如时序数据、空间数据、媒体数据、超文本数据、文本数据等等。

## 1.4 What kinds of Patterns can be mined?

+ 描述性（descriptive）：描述数据集数据的一般性质；
+ 预测性（predictive）：在当前数据集上进行归纳，从而做出预测。

### 1.4.1 特征化与区分（Characterization and discrimination）

特征化/区分主要用于类/概念描述（Class/Concept Description）

所谓特征化，就是目标类数据的一般特性或特征的汇总，即指定所需要研究的类（target class）的属性；所谓区分，就是将目标类与一个或者多个可比较类（contrasting class）进行比较，即不同类别数据之间的对比。

### 1.4.2 频繁模式、关联和相关性（Frequent Patterns, Associations and Correlations）

频繁模式：数据中频繁出现的模式；关联：各类数据之间是否有关联；相关性：对关联程度的一种度量。可见，三者之间是一种递进的关系，即如果存在某种频繁模式，则数据之间可能存在关联，如果数据样本满足最小支持度阈值（minimum sipport threshold）和最小置信度阈值（minimum confidence threshold），则可以用相关性来评估这种关联的程度。

### 1.4.3 分类和回归（Classification and Regression）

需要训练样本；用于预测。

### 1.4.4 聚类（Cluster）

聚类分析数据对象，不需要训练样本，不考虑所分的类别是什么。

### 1.4.5 离群点（Outlier）

在一般情况下，离群点（与一般模型不一致的数据点）被当作异常或噪声被抛弃；在某些情况下（如欺诈检测），离群点可能更有价值，可以利用离群点进行异常挖掘。

### 1.4.6 Are all Patterns interesting?

+ What makes a pattern interesting?

条件：①便于理解；②在某一级别的置信度上对新的数据有效；③潜在有用；④新颖。

+ Can a data mining system generate all of the interesting patterns?

涉及数据挖掘算法的完全性（completeness），挖掘出所有可能的模式是不现实的，通常需要根据用户提供的约束和兴趣度度量进行聚焦。

+ Can a data mining system generate only interesting patterns?

涉及算法优化的问题。

## 1.5 What Technologies Are used?

主要就是统计学，以及机器学习、深度学习相关的算法。

## 1.6 Which kinds of Applications are targeted?

应用广泛，如商业智能（BI）和Web搜索引擎（其是一种专门的计算机服务器，在Web上搜索信息，用户搜索查询的结果本质上就是由网页、图片等组成的一张表，Web搜索引擎的本质就是大型数据挖掘应用，通常需要处理在线数据）。

## 1.7 Major Issues in Data Mining

+ 挖掘方法上；
+ 用户交互上；
+ 有效性（Efficiency）与伸缩性(Scalability)（算法的有效性和可伸缩性，并行、分布式和增量式数据挖掘）；
+ 数据库类型的多样性（数据类型多样，动态、网络、全球性的数据库）；
+ 数据挖掘的社会层面的问题（隐私问题，数据挖掘的广泛性）。
