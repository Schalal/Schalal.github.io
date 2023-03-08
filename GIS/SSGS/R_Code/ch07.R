library(car)
library(spdep)
library(maptools)

setwd("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata")
 
prec <-readShapePoints("prec_stations.shp")
# 降雨量数据的QQ图
qqnorm(prec$Rainfall)
qqline(prec$Rainfall)
# S-W正态性检验
shapiro.test(prec$Rainfall)
# p-value = 4.134e-07，显著不正态
qqnorm(prec$rain_tr)
qqline(prec$rain_tr)
shapiro.test(prec$rain_tr)
# 转换后的降雨量数据
# p-value = 0.0289，正态性变好
library(gstat)
# 残差的变差函数图
# varigram: Calculates the sample variogram from data, or in case of a linear model is given, for the residuals, 
# with options for directional, robust, and pooled variogram, and for irregular distance intervals.
pr.v <- variogram(rain_tr ~ 1, prec)
# vgm: Generates a variogram model, or adds to an existing model
pr.vf.exp <- fit.variogram(pr.v, vgm(0.013,"Exp", 0.35, 0))
plot(pr.v, pr.vf.exp)

pr <- readShapePoly("PuertoRico.shp")
# 空间抽样
pr.reg <- spsample(pr, 100000, type="regular")
# SpatialPixels: defines spatial grid by offset, cell size and dimensions
pr.grid <- SpatialPixels(pr.reg)

ok.exp <- krige(rain_tr ~ 1, prec, pr.grid, pr.vf.exp)
color.pal <- colorRampPalette(c("dark red","orange","light Yellow"))
color.palr <- colorRampPalette(c("light yellow","orange","dark red"))
# 预测值
spplot(ok.exp["var1.pred"], col.regions=color.pal)
# 方差值
spplot(ok.exp["var1.var"], col.regions=color.palr)

# 使用另一种变差函数的模型
pr.vf.bes <- fit.variogram(pr.v, vgm(0.01,"Bes", 0.35, 0.002))
plot(pr.v, pr.vf.bes)

ok.bes <- krige(rain_tr ~ 1, prec, pr.grid, pr.vf.bes)
spplot(ok.bes["var1.pred"], col.regions=color.pal)
spplot(ok.bes["var1.var"], col.regions=color.palr)

# 协克里金
# gstat: Function that creates gstat objects; objects that hold all the
# information necessary for univariate or multivariate geostatistical prediction
# 其第一个参数：gstat object to append to; if missing, a new gstat object is created
ck.g <- gstat(NULL,"rain",rain_tr ~ 1,prec)
ck.g <- gstat(ck.g,"dem",dem_tr ~ 1,prec)

ck.v <- variogram(ck.g)
# fit.lmc: Fit a Linear Model of Coregionalization to a Multivariable Sample Variogram
# 使用指数模型
ck.vf.exp <- fit.lmc(ck.v, ck.g, vgm(0.013,"Exp", 0.35, 0))
ck.exp <- predict(ck.vf.exp, pr.grid)
spplot(ck.exp["rain.pred"], col.regions=color.pal)
spplot(ck.exp["rain.var"], col.regions=color.palr)
# 使用贝塞尔模型
ck.vf.bes <- fit.lmc(ck.v, ck.g, vgm(0.01,"Bes", 0.35, 0.002))
ck.bes <- predict(ck.vf.bes, pr.grid)
spplot(ck.bes["rain.pred"], col.regions=color.pal)
spplot(ck.bes["rain.var"], col.regions=color.palr)

# 使用ETM+数据作为协变量
library(psych)
lsat <- read.csv("landsat_tm.csv", header=T)
# 计算主成分
tm.pca <- principal(lsat[,4:10], 2, rotate="none", scores=T)
print(tm.pca$loadings, cutoff=0.001)
# 重新提取因子之和的数据
factors <- cbind(lsat[,1:3], tm.pca$scores)
coordinates(factors) <- c("x","y")
fact.grid <- factors
gridded(fact.grid) <- T
spplot(fact.grid,"PC2", col.regions=color.pal)
# 由于overlay函数无法使用，所以以下被注释的代码均无法执行
# pts <- overlay(fact.grid, prec)
# plot(factors$PC2[pts], prec$rain_tr, pch=20)
# tm.cor <- cor(factors$PC2[pts], prec$rain_tr)
# print(tm.cor)
# 
# # cokriging with tm: exponential
# ck.tm <- gstat(NULL, "rain", rain_tr ~ 1, prec, model=pr.vf.exp)
# vov <- var(factors$PC2)/var(prec$rain_tr)
# tm.vf.exp <- pr.vf.exp
# tm.vf.exp$psill <- pr.vf.exp$psill * vov
# ck.tm <- gstat(ck.tm, "tm", PC2 ~ 1, factors, nmax=8, model=tm.vf.exp)
# co.vf.exp <- pr.vf.exp
# co.vf.exp$psill <- sqrt(pr.vf.exp$psill * tm.vf.exp$psill) * tm.cor
# ck.tm <- gstat(ck.tm, c("rain","tm"), model=co.vf.exp)
# ck.tm.exp <- predict(ck.tm, pr.grid)
# spplot(ck.tm.exp["rain.pred"], col.regions=color.pal)
# spplot(ck.tm.exp["rain.var"], col.regions=color.palr)
# 
# # cokriging with tm: Bessel
# ck.tm.m <- gstat(NULL, "rain", rain_tr ~ 1, prec, model=pr.vf.bes)
# tm.vf.bes <- pr.vf.bes
# tm.vf.bes$psill <- pr.vf.bes$psill * vov
# ck.tm.m <- gstat(ck.tm.m, "tm", PC2 ~ 1, factors, nmax=8, model=tm.vf.bes)
# co.vf.bes <- pr.vf.bes
# co.vf.bes$psill <- sqrt(pr.vf.bes$psill * tm.vf.bes$psill) * tm.cor
# ck.tm.m <- gstat(ck.tm.m, c("rain","tm"), model=co.vf.bes)
# ck.tm.bes <- predict(ck.tm.m, pr.grid)
# spplot(ck.tm.bes["rain.pred"], col.regions=color.pal)
# spplot(ck.tm.bes["rain.var"], col.regions=color.palr)



# 7.3: spatial linear operator
pr.thiess <- readShapePoly("pr_thiessen.shp")
plot(pr.thiess)
plot(prec, add=T, pch=20)
thiess.nb <- read.gal("pr_thiessen.gal")
th.listw <- nb2listw(thiess.nb, style="W")
th.listb <- nb2listw(thiess.nb, style="B")

# 变换后的降水量
moran.test(prec$rain_tr, th.listb)
# p-value < 2.2e-16，显著的空间自相关
geary.test(prec$rain_tr, th.listb)
# p-value = 6.003e-15，显著的空间自相关
# SAR，变换后的降雨量的空间误差模型
rain.sar <- errorsarlm(prec$rain_tr ~ 1, listw=th.listw)
rain.sar$lambda
# \lambda=0.7949738
# 变换后的数据（旨在消除空间自相关）
rain.lf <- prec$rain_tr - rain.sar$lambda * lag.listw(th.listw, prec$rain_tr)

# 变换后的DEM值
moran.test(prec$dem_tr, th.listb)
# p-value < 2.2e-16，显著的空间自相关
geary.test(prec$dem_tr, th.listb)
# p-value = 4.168e-14，显著的空间自相关
elev.sar <- errorsarlm(prec$dem_tr ~ 1, listw=th.listw)
elev.sar$lambda
# \lambda=0.7923075
# 变换后的数据
elev.lf <- prec$dem_tr - elev.sar$lambda * lag.listw(th.listw, prec$dem_tr)

sd(cbind(prec$rain_tr, prec$dem_tr)) 
cor(prec$rain_tr, prec$dem_tr)
sd(cbind(rain.lf, elev.lf)) 
cor(rain.lf, elev.lf)

(sd(prec$rain_tr)/sd(rain.lf))^2
(sd(prec$dem_tr)/sd(elev.lf))^2

qqnorm(rain.lf);qqline(rain.lf)
qqnorm(elev.lf);qqline(elev.lf)

shapiro.test(rain.lf)
shapiro.test(elev.lf)
# 变换后S-W检验正态性显著增强

# 多元变量的情况

pr.farm <- read.csv("PR-farm-data.csv")
pr.nb <- read.gal("PuertoRico.gal")
pr.listw <- nb2listw(pr.nb, style="W")
pr.listb <- nb2listw(pr.nb, style="B")
y1 <- pr.farm$nofarms_02/pr.farm$area
y2 <- pr.farm$nofarms_07/pr.farm$area
y3 <- pr.farm$cuerdas_02/pr.farm$area
y4 <- pr.farm$cuerdas_07/pr.farm$area
y5 <- pr.farm$rain_mean
y6 <- pr.farm$rain_std
y7 <- pr.farm$elev_mean
y8 <- pr.farm$elev_std

y <- cbind(y1,y2,y3,y4,y5,y6,y7,y8)
y1.sar <- errorsarlm(y1 ~ 1, listw=pr.listw)
# 分别计算系数
y.rho <- apply(y, 2, function(x, listw) {errorsarlm(x~1, listw=listw)$lambda}, listw=pr.listw)
print(y.rho)

# 提取主成分
y.fa <- principal(y, 3, rotate="varimax", scores=T)
print(y.fa$loadings, cutoff=0.001)
# 消除空间自相关
f.lf <- function(x, listw, rho) {x - rho*lag.listw(listw, x)}
y.lf <- mapply(f.lf, as.data.frame(y), rho=y.rho, MoreArgs=list(listw=pr.listw))
# 提取消除自相关之后的主成分
y.lf.fa <- principal(y.lf, 3, rotate="varimax", scores=T)
print(y.lf.fa$loadings, cutoff=0.001)

sum(diag(cov(y)))
sum(diag(cov(y.lf)))

library(RColorBrewer)
library(classInt)

windows(w=14,h=7)
pal.red <- brewer.pal(7,"Reds")
q7 <- classIntervals(y.fa$scores[,1],7, style="quantile") 
cols.red <- findColours(q7, pal.red)
plot(pr, col=cols.red)
brks <- round(q7$brks,3)
leg <- paste(brks[-8], brks[-1], sep=" - ")
legend("bottomright", fill=pal.red, legend=leg, bty="n")
title("Original Factor 1")

source("all_functions.R")

mapping.seq(pr, y.lf.fa$scores[,1], 7, main="Spatial liner operator filtered Factor 1")   
mapping.seq(pr, y.fa$scores[,2], 7, main="Original Factor 2")   
mapping.seq(pr, y.lf.fa$scores[,2], 7, main="Spatial liner operator filtered Factor 2")   
mapping.seq(pr, y.fa$scores[,3], 7, main="Original Factor 3")   
mapping.seq(pr, y.lf.fa$scores[,3], 7, main="Spatial liner operator filtered Factor 3")   

# 多元方差分析

y.m <- manova(y ~ as.factor(pr.farm$ADM))

y.m.s <- summary(y.m, test="Wilks")
m.test <- c("Wilks", "Pillai", "Hotelling-Lawley", "Roy")
lapply(m.test, function(x, m) {summary(m,test=x)}, m=y.m)
round(y.m.s$Eigenvalues/sum(y.m.s$Eigenvalues)*100,2)

y.lf.m <- manova(y.lf ~ as.factor(pr.farm$ADM))
lapply(m.test, function(x, m) {summary(m,test=x)}, m=y.lf.m)
y.lf.meig <- summary(y.lf.m, test="Wilks")$Eigenvalues
round(y.lf.meig /sum(y.lf.meig )*100,2)

# cononical correlation
library(CCA)
uv <- pr.farm[,c("u","v")]
y.cc <- cc(uv, y)
y.cc[1]
round(y.cc$scores$corr.X.xscores,2)
round(y.cc$scores$corr.Y.yscores,2)

y.lf.cc <- cc(uv, y.lf)
y.lf.cc[1]
round(y.lf.cc$scores$corr.X.xscores,2)
round(y.lf.cc$scores$corr.Y.yscores,2)

mapping.seq(pr, y.cc$scores$xscores[,1], 7, main="Raw: Dimension 1")   
mapping.seq(pr, y.cc$scores$yscores[,1], 7, main="Raw: Dimension 1")
mapping.seq(pr, y.lf.cc$scores$xscores[,1], 7, main="SLOP: Dimension 1")   
mapping.seq(pr, y.lf.cc$scores$yscores[,1], 7, main="SLOP: Dimension 1")
mapping.seq(pr, y.cc$scores$xscores[,2]*1, 7, main="Raw: Dimension 2")  
mapping.seq(pr, y.cc$scores$yscores[,2]*1, 7, main="Raw: Dimension 2")   
mapping.seq(pr, y.lf.cc$scores$xscores[,2]*1, 7, main="SLOP: Dimension 1")   
mapping.seq(pr, y.lf.cc$scores$yscores[,2]*1, 7, main="SLOP: Dimension 1")

# Eigenvector spatial filtering 

evec <- read.table("pr_evecs.txt", header=T)
EV <- evec[,-(1:2)]

# 使用特征向量进行线性建模
rain <- pr.farm$rain_mean
lm.full <- lm(rain ~ ., data=EV)
rain.sf <- stepwise.forward(lm.full, lm(rain ~ 1, data=EV), 0.1, verbose=F)            
rain.sf.sum <- summary(rain.sf)

irr.tr <- log(pr.farm$irr_farms_07/ pr.farm$area + 0.04)
lm.full <- lm(irr.tr ~ ., data=EV)
irr.sf <- stepwise.forward(lm.full, lm(irr.tr ~ 1, data=EV), 0.1, verbose=F) 
irr.sf.sum <- summary(irr.sf)

rain.selev <- names(rain.sf$coefficient)[-1]
irr.selev <- names(irr.sf$coefficient)[-1]
# evc: 共同使用的特征向量
evc <- rain.selev[rain.selev %in% irr.selev]

# 进行多种特征向量组合的比较
lm.rain.c <- lm(rain ~ ., data=EV[,evc])
lm.rc.sum <- summary(lm.rain.c)
lm.irr.c <- lm(irr.tr ~ ., data=EV[,evc])
lm.ic.sum <- summary(lm.irr.c)

eu.r <- rain.selev[!(rain.selev %in% evc)]
lm.rain.u <- lm(rain ~ ., data=EV[,eu.r])
lm.ru.sum <- summary(lm.rain.u)

eu.i <- irr.selev[!(irr.selev %in% evc)]
lm.irr.u <- lm(irr.tr ~ ., data=EV[,eu.i])
lm.iu.sum <- summary(lm.irr.u)

# 二者残差的相关系数
r1 <- cor(rain.sf$residuals, irr.sf$residuals)

r2.x <- rain.sf.sum$r.squared
r2.y <- irr.sf.sum$r.squared

r2 <- cor(lm.rain.c$fitted.values, lm.irr.c$fitted.values)
r2.xc <- lm.rc.sum$r.squared
r2.yc <- lm.ic.sum$r.squared

r3 <- cor(lm.rain.u$fitted.values, irr.sf$residuals) 
r4 <- cor(rain.sf$residuals, lm.irr.u$fitted.values) 
r2.xu <- lm.ru.sum$r.squared
r2.yu <- lm.iu.sum$r.squared

r5 <- round(cor(lm.rain.u$fitted.values, lm.irr.u$fitted.values), 6)

r.xy <- r1*sqrt((1-r2.x)*(1-r2.y)) + r2*sqrt(r2.xc*r2.yc) + r3*sqrt(r2.xu*(1-r2.y)) + r4*sqrt((1-r2.x)*r2.yu)

lm.morantest(rain.sf, listw=pr.listb)$statistic
shapiro.test(rain.sf$residuals)$p.value
moran.test(rain.sf$fitted.values, listw=pr.listb)$estimate[1]

lm.morantest(irr.sf, listw=pr.listb)$statistic
# p-value=0.2958
shapiro.test(irr.sf$residuals)$p.value
# p-value=0.4848467
moran.test(irr.sf$fitted.values, listw=pr.listb)$estimate[1]

evec.th <- read.table("pr_thiessen_evecs.txt", header=T)

decomp.prec <- cor.decomp(prec$rain_tr, prec$dem_tr, evec.th[,-1]) 
decomp.prec$r.sq
decomp.prec$bi.cor
lm.morantest(decomp.prec$x.sf, listw=th.listb)$statistic
lm.morantest(decomp.prec$y.sf, listw=th.listb)$statistic
shapiro.test(residuals(decomp.prec$x.sf))$p.value
shapiro.test(residuals(decomp.prec$y.sf))$p.value
moran.test(decomp.prec$x.sf$fitted.values, listw=th.listb)$estimate[1]
moran.test(decomp.prec$y.sf$fitted.values, listw=th.listb)$estimate[1]
# 通过以上检验，可以证明空间滤波有效地消除了空间自相关性