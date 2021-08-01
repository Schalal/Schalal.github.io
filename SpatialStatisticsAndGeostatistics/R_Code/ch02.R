# 2.1 Creation of the topological network, calculation of the MC and the GR,
# and construction of the Moran Scatterplot and semi-variogram plot.
library(spdep)# Spatial Dependence:Weighting Schemes, Statistics
library(RColorBrewer)# ColorBrewer Palettes
library(classInt)# Choose Univariate Class Intervals
library(maptools)# Tools for Handling Spatial Objects

setwd("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata\\PuertoRico_SPCS")
# 读取shp文件，这里不推荐使用readShapePoly，使用rgdal的readOGR更好
pr <- readShapePoly("PuertoRico_SPCS.shp")
# 读取GAL文件，也就是geoda生成的记录邻接情况的文本文件
pr.nb <- read.gal("PuertoRico.GAL")
# B:原始权重，W:行标准化，C/U:全局标准化，S:variance-stabilizing coding scheme
pr.listw <- nb2listw(pr.nb, style="B")

# Plotting Spatial connectivity 
# retrieve (or set) spatial coordinates，提取的也就是面的质心坐标
cent <- coordinates(pr)
# 渲染pr这个shapefile，指定lwd(line width)为1.5
plot(pr, lwd=1.5)
# 以面的质心为坐标绘制邻域关系
plot(pr.nb, cent, add=T, col="red")

# $在R中的作用就是提取某一列，则这里提取的是nofarms_07列除以面积列的一列数据，也就是下面说的农场密度
# Farm Density in 2007
farm.den07 <- pr$nofarms_07/pr$area

# Mapping Farm Density in 2007
# 绘制农场密度对应的地图
# brewer.pal：Creates nice looking color palettes especially for thematic maps
# 分类数最少为3，有 sequential, diverging, and qualitative 三种不同的色板
# The sequential palettes names are  
# Blues BuGn BuPu GnBu Greens Greys Oranges OrRd PuBu PuBuGn PuRd Purples RdPu Reds YlGn YlGnBu YlOrBr YlOrRd
pal.red <- brewer.pal(5,"BuGn")
# 给农场密度数据按分位数分为5类，q5.den是一个列表，包括原始数据和间断点
q5.den <- classIntervals(farm.den07,5,style="quantile") 
# 按照分位数列表和之前已经定义的色带给每个间隔分配颜色，每个原始数据都将对应一个颜色
cols.den <- findColours(q5.den, pal.red)
# 按照分配的颜色渲染pr
plot(pr, col=cols.den)
# brks取三位小数，赋给brks.den
brks.den <- round(q5.den$brks,3)
# paste: Concatenate vectors after converting to character，即连接字符串
leg.txt  <- paste(brks.den[-6], brks.den[-1], sep=" - ")
# n: the type of box to be drawn around the legend. The allowed values are "o" (the default) and "n".
legend("bottomright", fill=attr(cols.den,"palette"), legend=leg.txt ,bty="n")

# Spatial autocorrelation tests
moran.test(farm.den07, pr.listw)
geary.test(farm.den07, pr.listw)

# Moran Scatterplot
moran.plot(farm.den07, pr.listw, pch=20)

# Variogram
library(gstat)
pr.v <- variogram(farm.den07 ~ 1,  pr)
# fit.variogram: Fit ranges and/or sills from a simple or nested variogram model to a sample variogram
# vgm: Generates a variogram model, or adds to an existing model，这里指定的是球状模型
pr.v.fit <- fit.variogram(pr.v, vgm(11,"Sph", "30000", 1))
plot(pr.v, pr.v.fit)

# 2.2 Calculation of the residual autocorrelation, and testing it for significance.
# Farm Density in 2002，即2002年的农场密度
farm.den02 <- pr$nofarms_02/pr$area

# Run a regression model，对2007年和2002年的农场密度进行线性回归建模
lm.farm <- lm(farm.den07 ~ farm.den02)
summary(lm.farm)
# 根据权重矩阵和线性模型进行莫兰检验，检验空间自相关性质
lm.morantest(lm.farm,pr.listw)

# Mapping residuals of the regression model，地图可视化模型残差
res <- resid(lm.farm)
q5.res <- classIntervals(res,5,style="quantile")  # 以分位数的分类方法将残差分为五类
cols.res <- findColours(q5.res, pal.red)  # 赋予颜色
plot(pr, col=cols.res)  # 绘制地图
# 添加图例
brks.res <- round(q5.res$brks,3)
leg.txt  <- paste(brks.res[-6], brks.res[-1], sep=" - ")
legend("bottomright", fill=attr(cols.res,"palette"), legend=leg.txt ,bty="n")