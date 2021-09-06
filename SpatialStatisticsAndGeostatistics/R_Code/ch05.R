library(car)
library(spdep)
library(RColorBrewer)
library(classInt)

setwd("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata")
pr.f <- read.csv(file="PR-farm-data.csv")

# 5.1 空间回归
# 求密度（单位化）
ifarm.den07 <- pr.f$irr_farms_07/pr.f$area
# Box-Cox变换，得到最终的农场灌溉数据
y <- log(ifarm.den07 + 0.04)
# 平均降水量
rain <- pr.f$rain_mean
# 对灌溉量和降水量进行线性模型拟合
if.lm <- lm(y ~ rain)
summary(if.lm)
# S-W检验，检验残差的正态性
shapiro.test(resid(if.lm))

# 读入空间权重矩阵的GAL数据，为空间回归作准备
pr.nb <- read.gal("PuertoRico.GAL")
# W表示行标准化，B表示原矩阵
pr.listw <- nb2listw(pr.nb, style="W")
pr.listb <- nb2listw(pr.nb, style="B")
# 空间回归
if.sar <- errorsarlm(y ~ rain, listw = pr.listw)
summary(if.sar)
if.res <- residuals(if.sar)
shapiro.test(if.res)

# 协方差
cor(y, rain)

# 估计系数λ和ρ的大小
y.sar <- errorsarlm(y ~ 1, listw=pr.listw)
y.sar$lambda
x.sar <- errorsarlm(rain ~ 1, listw= pr.listw)
x.sar$lambda
# 对变量做调整，“消除”空间自相关
y.sa <- y - y.sar$lambda * lag.listw(pr.listw,y)
rain.sa <- rain - x.sar$lambda * lag.listw(pr.listw,rain)
# 再计算协方差，发现其绝对值变小了
cor(y.sa, rain.sa)

# 对消除空间自相关后的灌溉量作方差分析，得到其均值可以认为相等
adm <- factor(pr.f$ADM, levels=1:5, labels= c("San Juan", "Arecibo", "Mayaguez", "Ponce", "Caguas"))
lm.if.sa <- lm(y.sa ~ adm)
anova(lm.if.sa)

# 求S-W检验p值的函数
sw.p <- function(x){   
  shapiro.test(x)$p.value}
# 对各区域的空间自相关残差作S-W检验和方差齐次检验
tapply(resid(lm.if.sa),adm,sw.p)
leveneTest(resid(lm.if.sa), adm, center=mean)


# 空间Logistic回归
# cl_ih：coastal lowland/interior highland二元分类属性
# 对其与降水量作线性回归及空间线性回归
ci <- pr.f$cl_ih
ci.lm <- lm(ci ~ rain, data=pr.f)
summary(ci.lm)
ci.sar <- errorsarlm(ci ~ rain, listw=pr.listw)
summary(ci.sar)

# 对cl_ih进行MC和GR的计算
moran.test(ci, pr.listb)
geary.test(ci, pr.listb)

n <- length(pr.nb)
M <- diag(n) - matrix(1,n,n)/n
B <- listw2mat(pr.listb)
MBM <- M %*% B %*% M
eig <- eigen(MBM,symmetric=T)
# 取最大特征值的0.25大的特征值对应的特征向量
EV <- as.data.frame( eig$vectors[,eig$values/eig$values[1]>0.25])
colnames(EV) <- paste("EV", 1:NCOL(EV), sep="")

# 使用特征向量进行Logistic回归
ci.full <- glm(ci ~ rain + ., data=EV, family=binomial)
ci.sf <- stepAIC(glm(ci ~ rain, data=EV, family=binomial), scope=list(upper= ci.full), direction="forward")
ci.sf <- glm(ci ~ rain + EV4 + EV2 + EV7 + EV9 + EV6 + EV14 + EV13 + EV18 + EV12, 
             data=EV, family=binomial)
summary(ci.sf)

# 对残差进行MC和GR检验
ci.sf.res <- round(residuals(ci.sf, type="response"))
moran.test(ci.sf.res , pr.listb)
geary.test(ci.sf.res , pr.listb)
# 此时，其p值均较大，可以认为已经不存在空间自相关了

# 读入shp数据，并按照地块类别填充颜色，并添加图例
library(sp)
library(maptools)
pr <- readShapePoly("PuertoRico.shp")
pal.wr <- c("white","red")
cols.wr <- pal.wr[ci+1]
plot(pr, col=cols.wr)
leg <- c("coastal", "interior")
legend("bottomright", fill=pal.wr, legend=leg, bty="n")

# 对回归结果按照分位数分段渐近填充，并添加图例
pal.red <- brewer.pal(5,"Reds")
q5 <- classIntervals(ci.sf$fitted, 5, style="quantile") 
cols.red <-findColours(q5, pal.red)
plot(pr, col=cols.red)
brks <- round(q5$brks,3)
leg <- paste(brks[-6], brks[-1], sep=" - ")
legend("bottomright", fill=pal.red, legend=leg, bty="n")

# 对回归结果四舍五入后再进行二元填充
cols.wr <- pal.wr[round(ci.sf$fitted)+1]
plot(pr, col=cols.wr)
leg <- c("coastal", "interior")
legend("bottomright", fill=pal.wr, legend=leg,bty="n")

# 使用灌溉技术的农场比例数据，这里是对该数据和降水量数据进行GML
fp <- pr.f$irr_farms_02/pr.f$nofarms_02
fp.col <- cbind(pr.f$irr_farms_02, pr.f$nofarms_02 - pr.f$irr_farms_02)
# 这里使用的是准二项分布
fp.base <- glm(fp.col ~ rain, family= quasibinomial)
disp <- summary(fp.base)$dispersion
fp.full <- glm(fp.col ~ rain + ., data=EV, family=binomial)
fp.sf <- stepAIC(glm(fp.col~rain, data=EV, family=binomial), scale=disp, scope= list(upper=fp.full), direction="forward")
fp.sf <- glm(fp.col ~ rain + EV1 + EV13 + EV4 + EV12 + EV2 + EV15, data=EV, family=quasibinomial)
summary(fp.sf)

moran.test(fp, pr.listb)
geary.test(fp, pr.listb)
summary(fp.base)$deviance/fp.base$df.residual
summary(fp.sf)$deviance/fp.sf$df.residual
summary(fp.sf)$dispersion

# 绘制农场灌溉比例的地图
source("all_functions.R")
mapping.seq(pr, fp, 5)

# 绘制预测的农场灌溉比例的地图
mapping.seq(pr, fp.sf$fitted, 5)

# 检验空间滤波的空间自相关性
sfilter <- as.matrix(EV[,c(1,13,4,12,2,15)]) %*% as.matrix(fp.sf$coefficients[c(-1,-2)])

moran.test(sfilter, pr.listb)
geary.test(sfilter, pr.listb)

# 检验使用空间滤波的GML的残差的空间自相关性
sf.res <- residuals(fp.sf, type="response")
moran.test(sf.res, pr.listb)
geary.test(sf.res, pr.listb)

mapping.seq(pr, sfilter, 5, main="SF")

#5.2.2.1
# 2007年农场密度数据
farm.den07 <- pr.f$nofarms_07/pr.f$area
# Box-Cox变换
y.fd <- (farm.den07 - 0.12)^0.38
# S-W正态性检验
shapiro.test(y.fd)
# 与降雨量进行线性回归
lm.fd <- lm(y.fd ~ rain)
lm.fd.s <- summary(lm.fd)
# 根据回归模型的值进行逆变换
s2 <- round(lm.fd.s$sigma^2,5)
c1 <- round(0.5 * (-0.25+(1/0.38-2+1.5)^2),5)
pred <- lm.fd$fitted
y.fd.e <- pred^(1/0.38) + c1*s2 + 0.12 

lm.bt <- lm(farm.den07 ~ y.fd.e)
summary(lm.bt)

# 不使用空间滤波进行泊松回归
pois.fd <- glm(nofarms_07 ~ rain_mean, offset=log(area), family=poisson, data=pr.f)
pois.fd$deviance/pois.fd$df.residual
nb.fd <- glm(nofarms_07 ~ rain_mean + offset(log(area)), data=pr.f, family=poisson)
nb.fd$deviance/nb.fd$df.residual
1/nb.fd$theta
nb.fit <- nb.fd$fitted/pr.f$area
nb.back <- lm(farm.den07 ~ nb.fit)
summary(nb.back)

par(mfrow=c(1,2))
plot(y.fd.e, farm.den07, pch=20)
abline(0,1, col=2)
nb.den <- fitted(nb.fd)/pr.f$area
plot(nb.den, farm.den07, pch=20)
abline(0,1, col=2)
par(mfrow=c(1,1))

moran.test(farm.den07, pr.listb)
geary.test(farm.den07, pr.listb)
moran.test(farm.den07-y.fd.e, pr.listb)
geary.test(farm.den07-y.fd.e, pr.listb)
moran.test(farm.den07-nb.fd$fitted/pr.f$area, pr.listb)
geary.test(farm.den07-nb.fd$fitted/pr.f$area, pr.listb)

# 使用空间特征滤波进行线性回归
lm.full <- lm(y.fd ~ rain + ., data=EV)
lm.sf <- stepwise.forward(lm.full, lm(y.fd ~ rain, data=EV), 0.1, verbose=F)         
summary(lm.sf)$r.squared
pred.sf <- lm.sf$fitted

s2.sf <- round(summary(lm.sf)$sigma^2,5)
y.e.sf <- pred.sf^(1/0.38) + c1*s2.sf + 0.12 
lm.sf.bt <- lm(farm.den07 ~ y.e.sf)
summary(lm.sf.bt)

plot(y.e.sf, farm.den07, pch=20)
abline(lm.sf.bt)

lm.sf.res <- farm.den07 - y.e.sf
moran(lm.sf.res, pr.listb, n, Szero(pr.listb))
geary(lm.sf.res, pr.listb, n, n-1, Szero(pr.listb))

X <- as.matrix(cbind(rep(1,n), lm.sf$model[,-1]))
num <- -n*sum(diag(solve(crossprod(X), crossprod(X,B)%*%X)))
den <- lm.sf$df.residual * sum(B)
num/den

nb.full <- glm(pr.f$nofarms_07 ~ rain + offset(log(pr.f$area)) + ., data=EV,family=poisson)
nb.sf <- stepAIC(glm.nb(pr.f$nofarms_07 ~ rain + offset(log(pr.f$area)), data=EV), scope=list(upper=nb.full), direction="forward")
nb.sf <- glm(pr.f$nofarms_07 ~ rain + EV12 + EV4 + EV1 + EV2 + EV18 + offset(log(pr.f$area)), data=EV, family=poisson)
summary(nb.sf)

glm.sf.bt <- lm(farm.den07 ~ I(nb.sf$fitted/pr.f$area))
summary(glm.sf.bt)

plot(nb.sf$fitted/pr.f$area, farm.den07, pch=20)
abline(glm.sf.bt)

glm.sf.res <- farm.den07 - nb.sf$fitted/pr.f$area
moran(glm.sf.res, pr.listb, n, Szero(pr.listb))
geary(glm.sf.res, pr.listb, n, n-1, Szero(pr.listb))

X <- as.matrix(cbind(rep(1,n), nb.sf$model[,c(-1,-8)]))
num <- -n*sum(diag(solve(crossprod(X), crossprod(X,B)%*%X)))
den <- nb.sf$df.residual * sum(B)
num/den

ur <- factor(pr.f$u_r, levels=0:1, labels=c("urban", "rural"))
tapply(y.fd, ur, sw.p)
leveneTest(y.fd, ur, center=mean)
anova(lm(y.fd ~ ur))

ur.d <- ifelse(pr.f$u_r==0,-1,1)
lm.full <- lm(y.fd ~ rain + ur.d + ., data=EV)      
lm.ur <- stepwise.forward(lm.full, lm(y.fd ~ rain + ur.d, data=EV), 0.1, verbose=F)
lm.ur.res <- residuals(lm.ur)
tapply(lm.ur.res, ur, sw.p)
leveneTest(lm.ur.res, ur, center=mean)
summary(lm.ur)$coefficients[3,]

nb.ur <- update(nb.sf, . ~ . + EV10 + EV15 + ur.d)
summary(nb.ur)$coefficients[10,]
nb.ur$deviance/nb.ur$df.residual


# 地理流计算

pr.j2w <- read.csv("PR_journey-to-work_2000.csv")

n <- sqrt(NROW(pr.j2w))

# model1
f.os <- function(x,flow.df,n){
  sum(flow.df[flow.df[,"ResID"]==x,"Count"])}
Oi.sum <- sapply(1:n, f.os, flow.df=pr.j2w, n=n)
Oi.sum <- rep(Oi.sum, each=n)

f.ds <- function(x,flow.df,n){ sum(flow.df[flow.df[,"WorkID"]==x,"Count"])}
Dj.sum <- sapply(1:n, f.ds, flow.df=pr.j2w, n=n)
Dj.sum <- rep(Dj.sum, n)
lnOiDj <- log(Oi.sum) + log(Dj.sum)

si.nc <- glm(Count ~ dist, offset=lnOiDj, data=pr.j2w, family=poisson)
exp(si.nc$coefficients[1])
si.nc$coefficients[2]
si.nc$deviance/si.nc$df.res
lm.nc <- lm(pr.j2w$Count~si.nc$fitted) 
summary(lm.nc)

# model2
b.id <- 63
fid.f <- as.factor(pr.j2w$ResID)
contr.f <- contr.treatment(levels(fid.f), base=b.id)
xo <- contr.f[fid.f,]
colnames(xo) <- paste("R", levels(fid.f)[-b.id], sep="")
rownames(xo) <- 1:(n^2)

tid.f <- as.factor(pr.j2w$WorkID)
contr.t <- contr.treatment(levels(tid.f), base=b.id)
xd <- contr.t[tid.f,]
colnames(xd) <- paste("W", levels(tid.f)[-b.id], sep="")
rownames(xd) <- 1:(n^2)

si.dc <- glm(Count ~ dist + xo + xd, offset=lnOiDj, data=pr.j2w, family=poisson)
exp(si.dc$coefficients[1])
si.dc$coefficients[2]
si.dc$deviance/si.dc$df.res
lm.dc <- lm(pr.j2w$Count~si.dc$fitted)
summary(lm.dc)


# model3
attach(pr.j2w)
# eigenvector treatment for flows
evec <- read.table("pr_evecs.txt", header=T)
evec <- evec[,c(-1,-2)]
EV <- evec[,1:11]
EVo <- apply(EV,2, function(x,n) {rep(x,each=n)}, n=n)
EVd <- apply(EV,2, function(x,n) {rep(x,n)}, n=n)
EVod <- kronecker(EVo, matrix(1,1,11)) * kronecker(matrix(1,1,11),EVd) * 100

colnames(EVod) <- paste("EV",1:121,sep="")
EVod.df <- as.data.frame(EVod)

#disp <- si.dc$deviance/si.dc$df.res
#si.full <- glm(Count ~ dist + xo + xd + ., data=EVod, family=poisson)
#si.sf <- stepAIC(glm(Count ~ dist + xo + xd, data=EVod, family=poisson), scale=disp, scope=list(upper=si.full), direction="forward", trace=0)

evs <- scan("pr_flow_sel_evecs.txt")
EVod.sel <- EVod[,evs]         

si.sf <- glm(Count ~ dist + xo + xd + EVod.sel, offset=lnOiDj, family=poisson)

exp(si.sf$coefficients[1])
si.sf$coefficients[2]
si.sf$deviance/si.sf$df.res
lm.sf <- lm(Count~si.sf$fitted)
summary(lm.sf)

plot(si.nc$fitted, Count, pch=4)
points(Count, Count)
plot(si.dc$fitted, Count, pch=4)
points(Count, Count)
plot(si.sf$fitted, Count, pch=4)
points(Count, Count)

detach(pr.j2w)

ai.v <-substr(names(si.sf$coef),1,3)=="xoR"
ai <- si.sf$coef[ai.v]

bj.v <-substr(names(si.sf$coef),1,3)=="xdW"
bj <- si.sf$coef[bj.v]

insert <- function(v,e,pos){ 
  return(c(v[1:(pos-1)], e,    
           v[(pos):length(v)]))}
ai <- insert(ai, 0, b.id)
bj <- insert(bj, 0, b.id)

ev.v <- substr(names(si.sf$ coef),1,8) == "EVod.sel"
ev.beta <- si.sf$coef[ev.v]
sf.if <- EVod.sel %*% ev.beta
sf.df <- pr.j2w[,c("ResID", "WorkID")]
sf.df$sfij <- sf.if

f.oi <- function(x,flow.df) { median( flow.df[flow.df[,"ResID"]==x,"sfij"])}
sf.oi <- sapply(1:n, f.oi, flow.df=sf.df)

f.dj <- function(x,flow.df) {median( flow.df[flow.df[,"WorkID"]==x,"sfij"])}
sf.dj <- sapply(1:n, f.dj, flow.df=sf.df)

mapping.seq(pr,ai,7,main="Org Balancing") 
mapping.seq(pr,bj,7,main="Dest Balancing") 
mapping.seq(pr,sf.oi,7,main="Org SF")
mapping.seq(pr,sf.dj,7,main="Dest SF")

