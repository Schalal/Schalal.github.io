# 第三章 Spark实战环境设定

## 3.1 建立Spark环境前提

+ 虚拟机与Linux安装：VMware WorkStation，CentOS
+ Windows与Linux交互：FinalShell，Putty
+ 语言环境：JDK，Python
+ 开发环境：Visual Studio Code，PyCharm

## 3.2 Spark环境搭建

+ Hadoop + Spark

## 3.3 建立Hadoop集群
## 3.4 安装与配置Hadoop集群
## 3.5 安装与配置Hive
## 3.6 打造交互式Spark环境

# 第四章 活用PySpark

## 4.1 Python基础
## 4.2 用PySpark建立第一个Spark RDD

RDD的建立：```parallelize|textFile|HDFS```
一个示例：

```Python
from pyspark import SparkConf, SparkContext

config = SparkConf().setAppName(value="WordCount").setMaster("local[*]")
sc = SparkContext(conf=config)

rdd = sc.parallelize(["Hello World", "Hello Spark"])
rdd2 = rdd.flatMap(lambda x: x.split(" "))
rdd3 = rdd2.map(lambda x: (x, 1))
rdd4 = rdd3.reduceByKey(lambda x, y: x + y)
print(rdd4.collect())
sc.stop()

```

