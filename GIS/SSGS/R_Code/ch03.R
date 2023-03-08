# 第三章，空间采样
# 3.1 使用spdep包进行空间采样操作
library(sp)
library(spdep)
library(maptools)
setwd("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata\\PuertoRico")

# 读取shp文件
pr <- readShapePoly("PuertoRico.shp")
n <- 90

# spsample函数要求坐标系基于平面直角坐标系，即便是椭球坐标系数据最后也是按平面直角坐标系处理的，返回SpatialPoints
# sample point locations within a square area, a grid, a polygon, or on a spatial line, 
# using regular or random sampling methods;
# 随机抽样
samp.rand <- spsample(pr, n, type="random")
plot(pr)
points(samp.rand, pch=20)

# 规则抽样
samp.reg <- spsample(pr, n, type="regular")
plot(pr, border="gray")
points(samp.reg, pch=20)

# 正六边形分层抽样
pr.hex <- readShapePoly("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata\\PR-hexagons\\pr-hexagons.shp")
n <- length(pr.hex)
# sapply()函数将列表，向量或数据帧作为输入，并以向量或矩阵形式输出。
# sapply(X, FUN, ..., simplify = TRUE, USE.NAMES = TRUE)
# slot(): These functions return or set information about the individual slots in an object.
# 对每个多边形进行1个随机抽样
# t()：矩阵转置
samp.xy <- sapply(slot(pr.hex,"polygons"), 
                  function(x) t(coordinates(spsample(x, 1, type="random"))))
samp.str <- cbind(samp.xy[1,],samp.xy[2,])

plot(pr, border="gray", lty=2)
plot(pr.hex, add=T)
points(samp.str, pch=20)


# 3.2 不使用sapply+spsample实现分层抽样 n:正六边形个数，Area：正六边形面积，link：正六边形邻接方式
sample.hex <- function(n, Area, link="vertical") {
  
  # Draw samples in quadrat I of a hexagon 
  loc <- matrix(0,n,2)  # 位置矩阵，初始化为0，n行2列
  i <- 1  # 计数
  rad <- sqrt(Area*2/(3*sqrt(3)))  # 正六边形半径
  

  if (link == "vertical") {
    while (i <= n) {
      uv <- runif(2)
      # 保证选取点在单位六边形内，本身就有条件0<x<1,0<y<sqrt(3)/2,再加上2x+y<2，也就是下面的x<1-0.5y
      # 就能保证了，但是由于使用随机数y本身的范围是(0,1)，这里采取了事后再变换的方式
      if (uv[1] < 1 - 0.5*uv[2]) {
        loc[i,] <- uv
        i <- i + 1
      }
    }
    # 变换坐标（防止纵坐标溢出），并缩放单位至半径大小，由于这里是vertical，所以纵坐标作变换，横坐标不变
    loc[,1] <- rad * loc[,1]
    loc[,2] <- sqrt(3)/2 * rad * loc[,2]  # 防止超限
  }
  else if (link == "horizontal") {
    while (i <= n) {
      uv <- runif(2)
      if (uv[2] < 1 - 0.5*uv[1]) {
        loc[i,] <- uv
        i <- i + 1
      }
    }
    loc[,1] <- sqrt(3)/2 * rad * loc[,1]
    loc[,2] <- rad * loc[,2]    
  }
  else 
    stop("The link is not correctly set")
  
  # Assign a quadrant
  # sample takes a sample of the specified size from the elements of x using either with or without replacement.
  qd <- sample(1:4,n,replace=T)
  # 根据随机生成的象限值变换符号
  loc[,1] <- ifelse((qd==2)|(qd==3), loc[,1]* -1, loc[,1])
  loc[,2] <- ifelse((qd==3)|(qd==4), loc[,2]* -1, loc[,2])
  return (loc)
}

# Read a hexagon shapefile
comp.hex <- readShapePoly("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata\\complete-hexagons\\complete-hexagons.shp")
n <- length(comp.hex)

# Get the area of a hexagon
hex1 <- slot(comp.hex,"polygons")[[1]]
Area <- slot(hex1,"area")

# Draw random samples in a hexagon
loc <- sample.hex(n, Area, link="vertical")

# sample.hex生成的点是相对位置，所以还需要加上质心点坐标
cent <- coordinates(comp.hex)
plot(comp.hex[1,])
# 绘制以第一个正六边形为中心得到的n个随机点
points(loc[,1] + cent[1,1], loc[,2] + cent[1,2], pch=20)

# 以各个六边形分别为中心，分别绘制采样点
samples.xy <- loc + cent
plot(comp.hex)
points(samples.xy, pch=20)


# Computer code 3.3

library(bootstrap)

pr.rd <- read.csv("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata\\pr_sample_random.csv", header=T)
pr.samp <- pr.rd[,"DEM_rs"]

# Bootstrap (1000 times)
n.s <- 1000
f.mean <- function(x){mean(x)}
bs.mean <- bootstrap(pr.samp, n.s, f.mean)
mean(bs.mean$thetastar)
sd(bs.mean$thetastar)

f.var <- function(x){var(x)}
bs.var <- bootstrap(pr.samp, n.s, f.var)
mean(bs.var$thetastar)
sd(bs.var$thetastar)

# JackKnifing
jk.mean <- jackknife(pr.samp, f.mean)
mean(jk.mean$jack.values)
jk.mean$jack.se

jk.var <- jackknife(pr.samp, f.var)
mean(jk.var$jack.values)
jk.var$jack.se
