## Data input format
+ list of dyads
+ adjacency matrix
+ adjacency list
## principles of network visualization
+ structure
+ 
+ element
+ layout：optimization for speed and aesthetic，如最小化节点和边的重叠，确保所有边长度的相似性

推荐软件：Gephi

## Local and global measures

### local
#### (1) popularity, importance and power（基于节点）
1. 度中心度 度的大小，degree centrality，```centrality(G, 'degree', 'Importance', G.Edges.Weight)```
2. 特征向量中心度 同时顾及邻接节点的度的大小，eigenvector centrality，```centrality(G, 'eigenvector', 'Importance', G.Edges.Weight)```
3. 接近中心性 到其他节点的最短距离之和越短，则接近中心度越高，closeness centrality，```centrality(G, 'closeness', 'Importance', G.Edges.Weight)```
4. 中介中心性 所有节点间最短路径通过某节点的次数y，betweenness centrality，```centrality(G, 'betweenness', 'Importance', G.Edges.Weight)```

centralities will be positively correlated. When they are not, it tells you something interesting.
||high d|high e|high b|high c|
|:----:|:----:|:----:|:----:|:----:|
||||||
||||||
||||||
||||||
||||||

other measures: 

random walk centrality
improved centrality measures of weighted networks

#### (2) dyads, homophily and mutuality（基于边）

relationship/connection

social theories defining relational ties: homophily: introduced into social theory by Lazrsfeld and Merton(1978).
+ status homophily
+ value homophily

two causes of homophily: (1) norm attribute; (2)structural location

summary of homophily(Kadushin, 2012)：相同属性的人的聚集->相互影响，在此过程中变得相似->end up in the same social position or placd->the very place influence them to become alike once they are in the same place.

four possible dyadic relationship: (0,0),(0,1),(1,0),(1,1)

measures:

1. edge betweenness
2. bridge: a bridge is a line whose removal will increases the number of components in the network.

Girvan-Newman algorithm for community detection

### global

different network structure: 
+ regular: all nodes have the same link
+ random: random connected
+ scale-free: hierarchical structure. few nodes with many connections and many nodes with few connections, e.g. air and maritime network.
+ small-world: dense connections among close neighbors and few among distant neighbors, e.g. multi-city highway network

+ network size，网络规模-->network density
+ component
+ isolate
+ centralization

measures of segregation

+ tradic closure
+ clustering coefficient

edge embeddedness



## mesoscale( or intermediate) structure

2 basic type:

+ community structrure
+ clusters with similar social positions

typology of mesoscale structure：可以用邻接矩阵表示社群之间的联系
+ assortative：边仅在每个社群内部存在
+ disassortative：边在不同的社群之间存在
+ core-periphery：核心社群与边缘社群存在联系，边缘社群之间互不联系
+ ordered：按照某一顺序两两社群之间存在联系
+ hybrid：

based on the typology, we have different mesoscale analysis:

+ cohesive subgroups
+ community detection
+ social positions/core-periphery/blockmodeling
+ stochastic mesoscale network analysis

## Cohesive Subgroups

why finding cohesive subgroups?

凝聚子群，找到最密集的组团即可，不关心其他节点，与community在概念上并不一致

properties leading to cohesive subgroups

+ cliques
+
+
+

一些衡量的指标：

+ component：同一组团内的节点相互连接，不同组团内的节点不连接
+ k-cores：a k-core is a maximum subnetwork in which each vertex has at least degree k within the subnetwork.
    一些属性：
+ k-clique：a set of vertices in which each vertex is directly connected to all other vertices. A clique is a maximal complete subnetwork containing three vertices or more. k is the size of a clique.
+ m-slice: a maximal subnetwork containing the lines with a weight equal to or greater than m and the vertices incident with these lines.
+ island: 
+ community: no comnsistent definition definition of communities!
 + community detection is important
 + the aim of cd is to identify ...


null model

modularity，模块度

$$
Q=\frac{1}{2m}\sum_{ij}{(A_{ij}-P_{ij})\delta(C_i, C_j)}
$$
