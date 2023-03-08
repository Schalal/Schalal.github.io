library (car)

setwd("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata")
pr.farm <- read.csv(file="PR-farm-data.csv")

# 4.1.2
# The function factor is used to encode a vector as a factor 
# (the terms ‘category’ and ‘enumerated type’ are also used for factors). 
# 给ADM字段数据分类，农场区域类别
adm <- factor(pr.farm$ADM, levels=1:5, labels=c("San Juan", "Arecibo","Mayaguez","Ponce","Caguas"))
# 计算单位面积的指标
land.den02 <- pr.farm$cuerdas_02/pr.farm$area

# 以San Juan区域的样本为例
# 求San Juan区域的密度均值及标准差
mean(land.den02[adm=="San Juan"])
sd(land.den02[adm=="San Juan"])
# S-W检验样本的正态性
shapiro.test(land.den02[adm=="San Juan"])
# 计算得到的p值为0.0259，因此可以拒绝原假设，即可以认为样本不符合正态分布

# 对所有区域的样本都分组求均值、方差及进行S-W检验
tapply(land.den02,adm,mean)
tapply(land.den02,adm,sd)
sw.p <- function(x) {shapiro.test(x)$p.value}
tapply(land.den02,adm,sw.p)
# Levene方差齐次性检验
leveneTest(land.den02, adm, center=mean)
# 计算得到的p值是0.632，因此不能拒绝原假设，说明可以认为方差齐次

# 作Box-Cox变换，使样本更接近正态
lden02.tr <- (land.den02+445)^-0.15 
# 再依次求各组的均值、标准差、正态性检验结果
tapply(lden02.tr, adm, mean)
tapply(lden02.tr, adm, sd)
tapply(lden02.tr, adm, sw.p)
# 对变换后的样本再进行Levene检验
leveneTest(lden02.tr, adm, center=mean)
# 计算得到的p值是0.3103，因此不能拒绝原假设，说明可以认为方差齐次

# 对变换前后的数据分别进行线性回归（实质上也就是计算均值？）和AVOVA
lm.l02.org <- lm(land.den02 ~ adm)
anova(lm.l02.org)
lm.l02.tr <- lm(lden02.tr ~ adm)
anova(lm.l02.tr)
# 检验结果是不能认为均值相等

# 对另一个字段的数据也进行类似的分析
land.den07 <- pr.farm$cuerdas_07/pr.farm$area
cl_ih <- factor(pr.farm$cl_ih,levels=0:1,labels=c("CL","IH"))
lden07.tr <- log(land.den07 + 211)

tapply(land.den07,cl_ih,mean)
tapply(land.den07,cl_ih,sd)
tapply(land.den07,cl_ih,sw.p)
# 变换前不能认为正态
tapply(lden07.tr,cl_ih,mean)
tapply(lden07.tr,cl_ih,sd)
tapply(lden07.tr,cl_ih,sw.p)
# 变换后可以认为正态
leveneTest(lden07.tr, cl_ih, center=mean)
# 可以认为方差齐次

lm.l07.org <- lm(land.den07 ~ cl_ih)
anova(lm.l07.org)
lm.l07.tr <- lm(lden07.tr ~ cl_ih)
anova(lm.l07.tr)

# 4.1.3
# 农场密度
farm.den02 <- pr.farm$nofarms_02/pr.farm$area
# 四个方向
quad <- factor(pr.farm$quad,levels=c(4,3,1,2),labels=c("NE","NW","SW","SE"))
# Box-Cox变换
fden02.tr <- log(farm.den02 + 0.35)

# S-W正态性检验
tapply(farm.den02,quad,sw.p)
tapply(fden02.tr,quad,sw.p)
# 变换后正态性显著增强
# levene方差齐次检验
leveneTest(fden02.tr, quad, center=mean)
# 方差齐次
lm.f02.tr <- lm(fden02.tr ~ quad)
anova(lm.f02.tr)
# Pr(>F)=0.0005139，结果显著，认为均值不全相等，存在着区域差异

#4.1.4
# 平均降水量
rain <- pr.farm$rain_mean
# 单位灌溉量
ifarm.den07 <- pr.farm$irr_farms_07/pr.farm$area
# 变换灌溉量数据
ifden07.tr <- log(ifarm.den07 + 0.04)
shapiro.test(ifden07.tr)
# 检验结果显示可以认为是正态的

# 绘制降水量和变换后单位灌溉量的散点图
plot(rain,ifden07.tr, pch=20)
# abline: This function adds one or more straight lines through the current plot.
abline(lm(ifden07.tr ~ rain)) 

lm.ifden07.tr <- lm(ifden07.tr ~ adm)
anova(lm.ifden07.tr) 
# Pr(>F)=0.007889，结果显著，认为均值不全相等，存在着区域差异

tapply(ifden07.tr,adm,sw.p)

leveneTest(ifden07.tr, adm, center=mean)
# -1表示不带截距
lm.ifden07.tr.rain <- lm(ifden07.tr ~ adm + rain - 1)
summary(lm.ifden07.tr.rain)

# 对残差进行方差齐次和正态检验
resids <- resid(lm.ifden07.tr.rain)
leveneTest(resids, adm, center=mean)
tapply(resids,adm,sw.p)