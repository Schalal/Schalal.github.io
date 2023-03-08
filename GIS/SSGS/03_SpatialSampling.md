# Chapter 3 Spatial Sampling

Simple random sampling: Equal possibilities are the most common ones asigned in classical statistics: every object has the same change of being selected for a sample.

## 3.1 Selected spatial sampling designs

One drawback of Simple random sampling is the possibility of drawing a very unrepresentative geographic sample, which means some regions may be over sampled while some undersampled.

Here are some strategies:

+ Geographically stratifying the sample by quadrat forces the sample points to disperse. Quadrat can be square, hexagon or other tessellation shape.
+ Systematic random sampling: randomly select a starting point, and then systematically selecting subsequent sample points by employ a predefined interval between points.
+ Cluster sampling: this approach rests on a strong assumption: an overall group comprises heterogeneous subgroups that are miscocosms of the overall group. A sample involves randomly selecting one of the subgroups. If the groups are sufficiently large,a second stage of sampling involves a simple random sample of the members constituting the selected subgroup.

## 3.2 Puerto Rico DEM Data

（本节主要就是以波多黎各的高程采样数据为例，比较了3.1节中提到的几种空间采样策略（不包括cluster采样）

## 3.3 Properties of the selected sampling designs: simulation experiment results

（本节主要就是以三种函数生成的确定性“高程”为背景，在正方形剖分和正六边形的情形下进行模拟实验，并比较随机采样，系统采样和分层采样的误差）

Differentiation between sample designs require the drawing of multiple samples.

A set of simulation experiments utilizing pseudorandom number generators and involving 10000 replications exploits the law of large numbers, and furnishes criteria for differentiating between the designs.

three designed landscape types, where $(U,V)$ is the coordinates:

+ linear geographic trend: $Z=U+V$
+ quadratic type of trend: $Z=e^{-[(U-0.5)^2+(V-0.5)^2]/2}$
+ oscillating type of trend: $Z=sin(5U\pi)+sin(4V\pi)$

two simulation experiments sets (two sample tessellation types):

+ unit square landscape
+ hexagonal landscape

Populations don't include a stochastic component, which means that the only chance component in the simulation experiments is sample error.

Results: a tessellation stratified design permits better estimation of variance, and generally is more precise.(Overton and Stehman, 1993)

## 3.4 Resampling techniques: reusing sampled data

Once a sample is selected, resampling techniques allow conducting of simulation experiments with this single sample that parallel the preceding simulation experiments.

two popular resample techniques:

|Name|Description|Notes|
|:----:|:----|:----|
|bootstrap|The bootstrap involves constructing a sample sampling distribution with replicate samples by random sampling with replacement from a single selected sample, using a sample of size $n$.|通俗来讲，就是在不知道样本分布状态的前提下，生成一系列基于样本bootstrap伪样本，每个伪样本是初始数据有放回等数量抽样。通过对n个伪样本的计算，获得相关统计量。不适用于镶嵌分层抽样。在确定抽样样本个数后，这种方法的重抽样样本个数仍是不确定的（因为不确定抽多少次）。|
|jack-knife|The jack-knife involves constructing a sample sampling distribution by systematically leaving out $k$ observations at a time from a selected sample, and recomputing a given statistic with the remaining sample size of $n-k$.|即，在抽样样本的基础上去除$k$个样本，生成新的样本集合，如假设抽样样本集共有$n$个样本，则去除1个，得到$n$个子样本构成的样本集合；去除2个，得到$\frac{n(n-1)}{2}$个子样本构成的样本集合；去除3个，得到$\frac{n(n-1)(n-2)}{6}$个子样本构成的样本集合，可以用于对偏差（bias）和标准差（standard error）的估计，在进行一些非线性统计量的计算的时候，可能还需要进行一些转换。在确定去除个数后，这种方法的重抽样样本个数是确定的。|

## 3.5 Spatial autocorrelation and effective sample size

Effective sample size is the equivalent number of independent values (the classical statistics situation). As spatial autocorrelation increases from 0 to 1, the effective sample size decreases from n to 1 .

In other words, on average, the judicously calculated effective sample size can contain all the information of spatial autocorrelation data values.
