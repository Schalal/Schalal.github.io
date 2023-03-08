# 第一章 大数据时代

## 1.1 什么是大数据
### 大数据的5V特点：

+ Volume：数据体量大-->分布式存储-->计算机集群/分布式文件系统
+ Velocity：高效地采集、处理和存储大量的数据
+ Variety：多源异构非结构化
+ Value：价值密度低
+ Veracity：真实性（准确性和及时性相对较高）<=来源多，可以相互印证

### 大数据的发展趋势

+ 是一种生产资料
+ 与物联网和5G的融合
+ 大数据理论的突破
+ 数据公开和标准化
+ 数据安全

## 1.2 大数据下的分析工具

高效安全地存储+高效及时地处理+机器学习挖掘数据并建立模型

奠基：

|论文名|内容|相关工具|
|:----:|:----:|:----|
|Google File System|大数据分布式存储|Hadoop HDFS，Kafka，Elasticsearch|
|Google MapReduce|大数据分布式计算|Hadoop MapReduce，Spark，Flink，Storm|
|Google BigTable|大数据分布式查询|Hive，HBase，Kylin，Impala，Presto，ClickHouse，Druid|
||分布式挖掘|Spark ML，Alink，Tensorflow，Torch|

其他：Apache Superset（大数据可视化），Jupyter Notebook（实时交互），Apache Zeppelin（实时交互）

# 第二章 Spark

## 2.1 Hadoop生态系统

Hadoop主要组件：
+ HDFS：Hadoop Distributed File System，分布式文件系统，提供对应用程序数据高吞吐量、高伸缩性、高容错性的访问，是Hadoop数据存储管理的基础
+ YARN：用于任务调度和集群资源管理
+ MapReduce：基于YARN的大型数据集并行处理系统，是一种分布式计算模型，用于进行大数据量的分布式计算

主要优点：
+ 可拓展性：可以添加数据节点拓展系统以处理更多数据
+ 灵活性：可以存储任意多的数据，将文件分解为块（block）进行存储；支持各种类型数据（结构化/非结构化/半结构化），适合一次写入、多次读取的场景
+ 低成本：开源免费，可以部署在低廉的硬件上
+ 容错机制：若某节点宕机则自动重定向到其他节点
+ 计算能力：数据节点越多，处理数据的能力越强，将计算移到数据节点上而非将数据移到计算计算机上

主要缺点：
+ 安全问题：数据没有加密，若需要在互联网上传输则有泄露的风险；
+ 小文件问题：缺乏有效支持小文件随机读取的能力

HDFS支持跨多台服务器进行数据存储，且数据会自动复制到不同的数据节点上，以防数据丢失，HDFS采用主从（Master/Slave）架构，一个HDFS集群由以下两种节点组成：
+ NameNode：存储文件系统的元数据的主节点，包括文件名、文件块信息、块位置、权限等，是数据管理节点；
+ DataNode：存储实际业务数据（块数据）的从节点，根据NameNode的指令为客户端读/写请求提供服务。

数据备份是HDFS可靠性和性能的关键，HDFS通过Rack-Aware策略为每个DataNode分配Rack ID。

Hadoop生态系统（略）

## 2.2 Spark与Hadoop

Spark出现之前，完成大数据分析任务需要多套工具，如离线分析用Hadoop MapReduce，查询数据用Hive，流数据处理用Storm，机器学习用Mahout------>数据格式转换费力，系统运维复杂----->Spark的目标：使用一个技术栈完美地解决大数据领域的各种计算任务（Spark RDD + Spark Streaming + Spark MLlib + Spark GraphX），Apache Spark™ is a multi-language engine for executing data engineering, data science, and machine learning on single-node machines or clusters.

Spark与Hadoop的比较：

||Hadoop|Spark|
|:----:|:----:|:----:|
|语言实现上|Java|Scala（基于JVM）|
|数据存储上|基于HDFS，磁盘IO|基于RDD，内存IO，如果内存不足则缓存到磁盘IO，效率更高|
|使用场景上|较为完备，适用于实时性要求不高的批处理任务计算|是一个计算框架，不提供分布式文件系统，需要与如HBase等集成使用|
|实现原理上|一个作业称为一个Job，Job分为Map Task和Reduce Task，进程随Task的结束而结束|一个作业称为一个Application，一个Application对应一个SparkContext，一个Application中存在多个Job，每触发一次Action就生成一个Job，Job可以并行或串行执行；一个Job内含多个Stage，一个Stage内含多个Task，由TaskScheduler分发到各个Executor中执行，Executor的生命周期与Application一致|

### Spark核心概念

Spark软件栈：

+ Spark Core: Spark Core包含Spark的基本功能，包含任务调度、内存管理和容错机制等，内部定义了RDD（Resilient Distributed Dataset，弹性分布式数据集），提供了很多API来创建和操作这些RDD，为其他组件提供底层的服务。
+ Spark SQL: Spark SQL可以处理结构化数据的查询分析，对于HDFS、HBase等多种数据源中的数据粗 粒 度 的 数 据 集 合 ， 包 含 一 个 或 多 个 数 据 分 片 ， 即，可以用Spark SQL来进行数据分析。
+ Spark Streaming: Spark Streaming是实时数据流处理组件，类似Storm。Spark Streaming提供了API来操作实时流数据。一般需要配合消息队列Kafka，来接收数据做实时统计分析。
+ Spark Mllib: MLlib是一个包含通用机器学习功能的包，是Machine Learning Lib的缩写，主要包括分类、聚类和回归等算法，还包括模型评估和数据导入。MLlib提供的机器学习算法库，支持集群上的横向扩展。
+ Spark GraphX: GraphX是专门处理图的库，如社交网络图的计算。与Spark Streaming和Spark SQL一样，也提供了RDD API。它提供了各种图的操作和常用的图算法。

Spark运行框架：

一些概念：

+ Application：提交一个作业就是一个Application，一个Application只有一个SparkContext。由群集上的驱动程序和执行程序组成。
+ Driver程序：一个Spark作业运行时会启动一个Driver进程，也是作业的主进程，负责作业的解析、生成Stage和调度Task到Executor上执行。Driver程序运行应用程序的main函数，并创建SparkContext进程。
+ Cluster Manager: Cluster Manager是用于获取群集资源的外部服务（如Standalone、YARN或Mesos），在Standalone模式中即为Master（主节点）。Master是集群的领导者，负责管理集群的资源，接收Client提交上来的作业，以及向Worker节点发送命令。在YARN模式中为资源管理器。
+ Worker: Worker节点是集群中的Worker，执行Master发送来的命令来具体分配资源，并在这些资源上执行任务Task。在YARN模式中为NodeManager，负责计算节点的控制。
+ Executor: Executor是真正执行作业Task的地方。Executor分布在集群的Worker节点上，每个Executor接收Driver命令来加载和运行Task。一个Executor可以执行一个到多个Task。多个Task之间可以互相通信。
+ SparkContext: SparkContext是程序运行调度的核心，由调度器 DAGScheduler 划分程序的各个阶段，调度器TaskScheduler划分每个阶段的具体任务。SchedulerBankend管理整个集群中为正在运行的程序分配计算资源的Executor。SparkContext是Spark程序入口。
+ DAGScheduler：负责高层调度，划分Stage，并生成程序运行的有向无环图。
+ TaskScheduler：负责具体Stage内部的底层调度、具体Task的调度和容错等。
+ Job: Job是工作单元，每个Action算子都会触发一次Job，一个Job可能包含一个或多个Stage。
+ Stage: Stage用来计算中间结果的Tasksets。Tasksets中的Task逻辑对于同一RDD内的不同Partition都一样。Stage在Shuffle的时候产生，如果下一个Stage要用到上一个Stage的全部数据，则要等上一个Stage全部执行完才能开始。Stage有两种：ShuffleMapStage和ResultStage。除了最后一个Stage 是 ResultStage 外 ， 其他的 Stage 都是ShuffleMapStageShuffleMapStage会产生中间结果，以文件的方式保存在集群里，Stage经常被不同的Job共享，前提是这些Job重用了同一个RDD。
+ Task: Task是任务执行的工作单位，每个Task会被发送到一个Worker节点上，每个Task对应RDD的一个Partition。
+ Taskset：划分的Stage会转换成一组相关联的任务集。
+ RDD: RDD指弹性分布数据集，它是不可变的、Lazy级别的、粗粒度的数据集合 ， 包含一个或多个数据分片 ， 即Partition。
+ DAG: DAG（Directed Acyclic Graph）指有向无环图。Spark实现了DAG计算模型，DAG计算模型是指将一个计算任务按照计算规则分解为若干子任务，这些子任务之间根据逻辑关系构建成有向无环图。
+ 算子： Spark中两种算子 ： Transformation 和 Action 。Transformation算子会由DAGScheduler划分到pipeline中，是Lazy级别的，它不会触发任务的执行。而Action算子会触发Job来执行pipeline中的运算。
+ 窄依赖：窄依赖（Narrow Dependency）指父RDD的分区只对应一个子RDD的分区。如果子RDD只有部分分区数据损坏或者丢失，只需要从对应的父RDD重新计算即可恢复。
+ 宽依赖：宽依赖（Shuffle Dependency）指子RDD分区依赖父RDD的所有分区。如果子RDD部分分区甚至全部分区数据损坏或丢失，则需要从所有父RDD上重新进行计算。相对窄依赖而言，数据处理的成本更高，所以应尽量避免宽依赖的使用。
+ Lineage：每个RDD都会记录自己依赖的父RDD信息，一旦出现数据损坏或者丢失，将从父RDD迅速重新恢复。

Spark的部署模式（略）

## 2.4 Spark基本操作

Spark对内存数据的抽象，即为RDD。RDD是一种分布式、多分区、只读的数组，Spark相关操作都是基于RDD进行的。Spark可以将HDFS块文件转换成RDD，也可以由一个或多个RDD转换成新的RDD。基于这些特性，RDD在分布式环境下能够被高效地并行处理。PySpark是Apache Spark社区发布的一个工具，让熟悉Python的开发人员可以方便地使用Spark组件。PySpark借助Py4j库，可以使用Python编程语言处理RDD。

PySpark首先利用Python创建SparkContext对象，然后用Socket与JVM上的SparkContext通信，当然，这个过程需要借助Py4J库。JVM上的Spark Context负责与集群上的SparkWorker节点进行交互。在PySpark中，对RDD提供了Transformation和Action两种操作类型。Transformation操作非常丰富，采用延迟执行的方式，在逻辑上定义了RDD的依赖关系和计算逻辑，但并不会真正触发执行动作，只有等到Action操作才会触发真正执行操作。Action操作常用于最终结果的输出。

从HDFS文件生成 RDD ，经过map、filter、join等多次Transformation操作，最终调用saveAsTextFile操作，将结果输出到HDFS中，并以文件形式保存。在PySpark中，RDD可以缓存到内存或者磁盘上，提供缓存的主要目的是减少同一数据集被多次使用的网络传输次数，提高PySpark的计算性能。PySpark提供对RDD的多种缓存级别，可以满足不同场景对RDD的使用需求。RDD的缓存具有容错性，如果有分区丢失，可以通过系统自动重新计算。

常用的Transformation操作

常用的Action操作

## 2.5 Spark SQL

Spark SQL的前身是Shark，即Hive on Spark，本质上是通过Hive的HQL进行解析，把HQL翻译成Spark上对应的RDD操作，然后通过Hive的Metadata获取数据库里的表信息，最后获取相关数据并放到Spark上进行运算。

Spark SQL的主要特点：

+ SchemaRDD：引入了新的RDD类型SchemaRDD，可以像传统数据库定义表一样来定义RDD。SchemaRDD由列数据类型和行对象
构成。它与RDD可以互相转换
+ 多数据源支持：可以混合使用不同类型的数据，包括Hadoop、Hive、JSON、Parquet和JDBC等
+ 内存列存储：Spark SQL的表数据在内存中采用内存列存储（In-Memory Columnar Storage），这样计算的速度更快
+ 字节码生成技术：Spark 1.1.0版本后在Catalyst模块的Expressions增加了Codegen模块，使用动态字节码生成技术，对匹配的表达式采用特定的代码动态编译。另外，对SQL表达式也做了优化。因此，效率进一步提升。

## 2.6 Spark机器学习

（略）

