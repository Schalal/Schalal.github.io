library(spdep)
library(classInt)
library(maptools)

setwd("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata")
pr <- readShapePoly("PuertoRico.shp", proj4string=CRS("+proj=longlat +ellps=WGS84"))

pr.f <- read.csv(file="PR-farm-data.csv")
pr.nb <- read.gal("PuertoRico.GAL")
# 空间权重阵
pr.listw <- nb2listw(pr.nb, style="W")
# 行标准化的空间权重阵
pr.listb <- nb2listw(pr.nb, style="B")

# 6.2
# 2002年农场密度
f.den02 <- pr.f$cuerdas_02/pr.f$area
# 空间误差模型
f.d.sar <- errorsarlm(f.den02 ~ 1, listw=pr.listw)
f.d.sar$lambda
# \lambda=0.5054677

# z分数阈值
z <- c(1.65, 1.96)
# 调整的z分数阈值
zc <- c(2.8284, 3.0471)
# 调整的t检验分数阈值
fc <- c(3.1845, 3.4920) 
# Bonferroni检验类型的z分数阈值
bf <- c(3.2009, 3.3955) 

# 计算农场密度的局部MC
f.Ii <- localmoran(f.den02, pr.listb)
zIi <- f.Ii[,"Z.Ii"]
mx <- max(zIi)
mn <- min(zIi)

# 给z分数阈值分隔的区间绘图
pal <- c("white", "red1", "red4")
# 指定间隔分段
z3.Ii <- classIntervals(zIi, n=3, style="fixed", fixedBreaks=c(mn, z, mx))
# 给颜色赋值
cols.Ii <- findColours(z3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(z3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")              

# 调整的z分数阈值
zc3.Ii <- classIntervals(zIi, n=3, style="fixed", fixedBreaks=c(mn, zc, mx))
cols.Ii <- findColours(zc3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(zc3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")

# t statistics
fc3.Ii <- classIntervals(zIi, n=3, style="fixed", fixedBreaks=c(mn, fc, mx))
cols.Ii <- findColours(fc3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(fc3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")

# Bonferroni adjustment
bf3.Ii <- classIntervals(zIi, n=3, style="fixed", fixedBreaks=c(mn, bf, mx))
cols.Ii <- findColours(bf3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(bf3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")


# 更新权重阵，自身也算邻域
pr.nb.s <- include.self(pr.nb)
# 行标准化的自身邻域权重阵
pr.listb.s <- nb2listw(pr.nb.s,style="B")
f.Gi <- localG(f.den02, pr.listb.s)

# 固定间隔分级设色
pal.rb <- c("blue","white","red","red4")
z4.Gi <- classIntervals(f.Gi, n=4, style="fixed", fixedBreaks=c(min(f.Gi), -zc[1], zc[1], zc[2], max(f.Gi)))
cols.Gi <- findColours(z4.Gi, pal.rb)               
plot(pr, col=cols.Gi)
brks <- round(z4.Gi$brks,4)
leg <- paste(brks[-5], brks[-1], sep=" - ")
legend("bottomright", fill= pal.rb, legend=leg, bty="n")

t3.Gi <- classIntervals(f.Gi, n=3, style="fixed", fixedBreaks=c(min(f.Gi), fc[1], fc[2], max(f.Gi)))
cols.Gi <- findColours(t3.Gi, pal)               
plot(pr, col=cols.Gi)
brks <- round(t3.Gi$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")

# 标准化
z.f <- scale(f.den02)
# ifelse(test, yes, no), ifelse returns a value with the same shape as test which is filled with elements selected from either 
# yes or no depending on whether the element of test is TRUE or FALSE.
ur.c <- ifelse(pr.f$u_r==1,1,-1)
# 特征向量文件的所有数据
evec <- read.table("pr_evecs.txt",header=T)
# 只取特征向量数值
EV <- evec[,-(1:2)]
sEV <- cbind(EV, ur.c * EV)
# 列名重命名
colnames(sEV) <- c(colnames(EV), paste("xEV", 1:NCOL(EV), sep=""))

# lm + .:表示必须有data的依赖
# lm data:If not found in data, the variables are taken from environment(formula), 
# typically the environment from which lm is called.
sv.full <- lm(z.f ~ ur.c + ., data=sEV)
summary(sv.full)
# 结果表示非常不显著
library(MASS)
# 逐步回归
sv.sf <- stepAIC(lm(z.f ~ ur.c, data=sEV), scope=list(upper=sv.full), direction="forward")
summary(sv.sf)
# 显示模型显著了很多

# 根据逐步回归结果，挑选特别显著的自变量进行多元线性回归
sv.sf <- lm(z.f ~ ur.c + EV10 + xEV8 + EV1 + xEV1 + EV3 + EV12 + EV9, data=sEV)         
summary(sv.sf)
# 在R语言中，对于串列，数据框中的数据的进行操作时，为了避免重复地键入对象名称，可使用attach
attach(sEV)
sv.int <- 0.0052 + 3.0909*EV1 - 1.4900*EV3 - 1.2975*EV9 + 3.0649*EV10 + 1.4365*EV12 
sv.slp <- -0.2579 + 2.3006*xEV1 + 2.4197*xEV8 
detach(sEV)

summary(sv.int)
summary(sv.slp)

pal.rb3 <- c("blue","white","red")
f3.int <- classIntervals(sv.int, n=3, style="fixed", fixedBreaks=c(min(sv.int), -0.6, 0.6, max(sv.int)))
cols.int <- findColours(f3.int, pal.rb3)               
plot(pr, col=cols.int)
brks <- round(f3.int$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill= pal.rb3, legend=leg, bty="n")

f3.slp <- classIntervals(sv.slp, n=3, style="fixed", fixedBreaks=c(min(sv.slp), -0.4, 0.4, max(sv.slp)))
cols.slp <- findColours(f3.slp, pal.rb3)               
plot(pr, col=cols.slp)
brks <- round(f3.slp$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill= pal.rb3, legend=leg ,bty="n")

plot(sv.slp, sv.int, pch=20)
cor(sv.slp,sv.int)