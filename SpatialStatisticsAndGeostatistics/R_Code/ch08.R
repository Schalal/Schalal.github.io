library(spdep)
library(gstat)

# 8.1
setwd("C:\\ssgs")
pr.outline <- readShapePoly("pr_outline.shp")
station <- readShapePoints("stations46.shp")
stn.df <- as.data.frame(station)
plot(pr.outline)
plot(station, add=T, pch=20)

# scatterplot
plot(scale(station$elevation), station$temperatur, pch=20)

# kriging out grid
pr <- readShapePoly("PuertoRico.shp")
pr.reg <- coordinates(spsample(pr, 100000, type="regular"))
colnames(pr.reg) <- c("x", "y")
pr.grid <- SpatialPixels(SpatialPoints(pr.reg))

# kriging (expoential model)
t.v <- variogram(temperatur ~ 1, station)
t.vf.exp <- fit.variogram(t.v, vgm(20,"Exp", 0.25, 3))
ok.t.exp <- krige(temperatur ~ 1, station, pr.grid, t.vf.exp)
color.pal <- colorRampPalette(c("dark red","orange","light Yellow"))
color.palr <- colorRampPalette(c("light yellow","orange","dark red"))
spplot(ok.t.exp["var1.pred"], col.regions=color.pal)
spplot(ok.t.exp["var1.var"], col.regions=color.palr)

# kriging with quadratic trend (expoential model)
t.v.tr <- gstat(NULL, "temp", temperatur ~ x^2 + x*y + y^2, station)
t.vm.tr <- variogram(t.v.tr)
t.vf.tr.exp <- fit.lmc(t.vm.tr , t.v.tr, vgm(15,"Exp", 0.25, 4))
t.tr.exp <- predict(t.vf.tr.exp, pr.grid)
spplot(t.tr.exp["temp.pred"], col.regions=color.pal)
spplot(t.tr.exp["temp.var"], col.regions=color.palr)

# cokriging with elevation (expoential model)
rs.temp <- read.csv("pr_elev_rs.csv")
rs.pts <- SpatialPoints(cbind(rs.temp[,c("x","y")]))
rs.spf <- SpatialPointsDataFrame(rs.pts, rs.temp)

t.ck.v <- gstat(NULL, "temp", temperatur ~ 1, station, model=t.vf.exp)
rs.vf.exp <- t.vf.exp
vov <- var(rs.temp$elevation)/var(station$temperatur)
rs.vf.exp$psill <- t.vf.exp$psill * vov
t.ck.v <- gstat(t.ck.v, "elev", elevation ~ 1, rs.spf, nmax=8, model=rs.vf.exp)
co.vf.exp <- t.vf.exp
co.vf.exp$psill <- sqrt(t.vf.exp$psill * rs.vf.exp$psill) * cor(station$elevation, station$temperatur)
t.ck.v <- gstat(t.ck.v, c("temp", "elev"), model=co.vf.exp)
ck.x.exp <- predict(t.ck.v, pr.grid)
spplot(ck.x.exp["temp.pred"], col.regions=color.pal)
spplot(ck.x.exp["temp.var"], col.regions=color.palr)

# kriging (bessel model)
t.v <- variogram(temperatur ~ 1, station)
t.vf.bes <- fit.variogram(t.v, vgm(10,"Bes", 0.18, 5))
ok.t.bes <- krige(temperatur ~ 1, station, pr.grid, t.vf.bes)
spplot(ok.t.bes["var1.pred"], col.regions=color.pal)
spplot(ok.t.bes["var1.var"], col.regions=color.palr)

# kriging with quadratic trend (bessel model)
t.v.tr <- gstat(NULL, "temp", temperatur ~ x^2 + x*y + y^2, station)
t.vm.tr <- variogram(t.v.tr)
t.vf.tr.bes <- fit.lmc(t.vm.tr , t.v.tr, vgm(10,"Bes", 0.18, 5))
t.tr.bes <- predict(t.vf.tr.exp, pr.grid)
spplot(t.tr.bes["temp.pred"], col.regions=color.pal)
spplot(t.tr.bes["temp.var"], col.regions=color.palr)

# cokriging with elevation (bessel model)
t.ck.v <- gstat(NULL, "temp", temperatur ~ 1, station, model=t.vf.bes)
rs.vf.bes <- t.vf.bes
vov <- var(rs.temp$elevation^0.35)/var(station$temperatur)
rs.vf.bes$psill <- t.vf.bes$psill * vov
t.ck.v <- gstat(t.ck.v, "elev", elevation^0.35 ~ 1, rs.spf, nmax=8, model=rs.vf.bes)
co.vf.bes <- t.vf.bes
co.vf.bes$psill <- sqrt(t.vf.bes$psill * rs.vf.bes$psill) * cor(station$elevation^0.35, station$temperatur)
t.ck.v <- gstat(t.ck.v, c("temp", "elev"), model=co.vf.bes)
ck.x.bes <- predict(t.ck.v, pr.grid)
spplot(ck.x.bes["temp.pred"], col.regions=color.pal)
spplot(ck.x.bes["temp.var"], col.regions=color.palr)


# 8.2 
em.lm <- lm(temperatur ~ elevation, data=station)
summary(em.lm)
elev.obs <- data.frame(elevation=rs.temp$elevation)
em.lm.pred <- predict(em.lm, elev.obs, interval="prediction")

# predicted values
kr.pts <- overlay(t.tr.exp["temp.pred"], rs.pts) 
kr.pred <- as.data.frame(t.tr.exp["temp.pred"])[kr.pts,]
plot(em.lm.pred[,"fit"], kr.pred$temp.pred, pch=20, cex=0.5,xlab="EM Imputation temperature", ylab="krigged temperature")
abline(lm(kr.pred$temp.pred~em.lm.pred[,"fit"]),col=4, lwd=2)

# errors
kr.var <- as.data.frame(t.tr.exp["temp.var"])[kr.pts,]
der <- em.lm.pred[,"upr"]-em.lm.pred[,"fit"]
plot(der, sqrt(kr.var$temp.var), pch=20, cex=0.5, xlab="EM prediction error", ylab="krigged prediction error")
abline(lm(sqrt(kr.var$temp.var)~der),col=4, lwd=2)

# 8.3
pr.farm <- read.csv("PR-farm-data.csv")

elev.mean.tr <- log(pr.farm$elev_mean + 17.5)
elev.std.tr <- sqrt(pr.farm$elev_std - 25)

source("all_functions.R")
mapping.seq(pr, elev.mean.tr, 9, main="Mean Elevation")  
mapping.seq(pr, elev.std.tr, 9, main="Eelvation Standard Deviation")  

pr.nb <- read.gal("PuertoRico.gal")
pr.listw <- nb2listw(pr.nb, style="W")
errorsarlm(elev.mean.tr ~ elev.std.tr, listw=pr.listw)$lambda

n <- length(pr.nb)
x <- elev.std.tr 
wx <- lag.listw(pr.listw, x)
eig.values <- eigenw(pr.listw)
rho.range <- 1/range(eig.values)

em.sar.out <- matrix(0,n,4)
colnames(em.sar.out) <- c("rho","b0","b1","ymp")

fr <- function(pars, y, wy, x, wx, eig.values, imp, cimp) {
  rho <- pars[1]
  b0 <- pars[2]
  b1 <- pars[3]
  ymp <- pars[4]
  jacob <- sum(log(1 - rho*eig.values))
  j <- exp(jacob/72)
  sum(((rho*wy + b0*(1-rho) + b1*(x - rho*wx) + ymp*(imp + rho*cimp)-y)/j)^2)
}

grr <- function(pars, y, wy, x, wx, eig.values, imp, cimp) {
  rho <- pars[1]
  b0 <- pars[2]
  b1 <- pars[3]
  ymp <- pars[4]
  jacob <- sum(log(1 - rho*eig.values))
  j <- exp(jacob/72)
  derj <-  sum(eig.values/(1 - rho*eig.values))/72
  
  expr1 <- 1 - rho
  expr2 <- x - rho * wx
  expr3 <- imp + rho * cimp
  expr4 <- rho * wy + b0 * expr1 + b1 * expr2 + ymp * expr3 - y
  
  g.rho <- sum(2 * ((wy - b0 - b1*wx + ymp * cimp)/j + expr4 * j* derj/j^2) * expr4/j)
  g.b0 <-  sum(2 * expr1/j * expr4/j)
  g.b1 <-  sum(2 * expr2/j * expr4/j)
  g.ymp <- sum(2 * expr3/j * expr4/j)
  c(g.rho, g.b0, g.b1, g.ymp)
}

get.cimp <- function(x, listw){
  n <- length(listw$neighbours)
  cimp <- rep(0,n)
  nbs <- pr.listw$neighbours[[i]]
  for (j in 1:length(nbs)) {
    c.nb <- nbs[j] 
    c.nb.i <- pr.listw$neighbours[[c.nb]]==i
    cimp[c.nb] <- pr.listw$weights[[c.nb]][c.nb.i]
  }
  return(cimp)  
}

for (i in 1:n) {
  y <- elev.mean.tr
  y[i] <- 0
  wy <- lag.listw(pr.listw, y)
  
  cimp <- get.cimp(i, pr.listw)
  imp <- rep(0,n)
  imp[i] <- -1  
  opt <- nlminb(c(rho=0.5, b0=0, b1=0, ymp=0), fr, grr, y=y, wy=wy, x=x, wx=wx,
                eig.values=eig.values, imp=imp, cimp=cimp, lower=c(rho.range[1], rep(-Inf,3)),
                upper=c(rho.range[2], rep(Inf,3)), control=list(iter.max=1000))
  em.sar.out[i,] <- opt$par
}

lm.em.sar <- lm(elev.mean.tr~em.sar.out[,4])
summary(lm.em.sar)
plot(em.sar.out[,4], elev.mean.tr, pch=20)
abline(lm.em.sar)

qqnorm(em.sar.out[,1],pch=20)
qqline(em.sar.out[,1])
mean(em.sar.out[,1])
sd(em.sar.out[,1])

resids <- elev.mean.tr - em.sar.out[,4]
qqnorm(resids, pch=20)
qqline(resids)


# 8.4: Eigenvector spatial filtering EM

# normal
evec <- read.table("pr_evecs.txt", header=T)
EV <- evec[,-(1:2)]

elev.base <- lm(elev.mean.tr ~ elev.std.tr)
summary(elev.base)$r.squared
elev.full <- lm(elev.mean.tr ~ elev.std.tr + ., data=EV)
elev.sf <- stepwise.forward(elev.full, lm(elev.mean.tr ~ elev.std.tr, data=EV), 0.1, verbose=F) 

n <- length(elev.mean.tr)
esf.em.out <- matrix(NA, n, 2)
colnames(esf.em.out) <- c("imputed", "# of EVs")
for (i in 1:n){
  y <- elev.mean.tr
  iv <- rep(0,n)
  y[i] <- 0
  iv[i] <- -1
  
  xyEV <- as.data.frame(cbind(y, x=elev.std.tr, EV, iv))
  elev.base <- lm(y ~ x, data=xyEV)
  elev.full <- lm(y ~ iv + ., data=xyEV)
  elev.sf <- stepwise.forward(elev.full, lm(y ~ iv + x, data=xyEV), 0.1, verbose=FALSE) 
  esf.em.out[i,1] <- elev.sf$coefficients[2] 
  esf.em.out[i,2] <- elev.sf$rank-1 
}

imp.lm <- lm(elev.mean.tr~esf.em.out[,1])
plot(esf.em.out[,1], elev.mean.tr, pch=20)
abline(lm(elev.mean.tr~esf.em.out[,1]))

resids <- elev.mean.tr - esf.em.out[,1]
qqnorm(resids, pch=20)
qqline(resids)

r.sqs <- matrix(NA, n, 2)
colnames(r.sqs) <- c("r.sq", "base.sq")
for (i in 1:n){
  yx <- elev.mean.tr
  iv <- rep(0,n)
  yx[i] <- NA
  
  xyEV <- as.data.frame(cbind(yx, x=elev.std.tr, EV))
  elev.full <- lm(yx ~ ., data=xyEV)
  elev.sf <- stepwise.forward(elev.full, lm(yx ~ x, data=xyEV), 0.1, verbose=FALSE) 
  elev.base <- lm(yx ~ x, data=xyEV)
  r.sqs[i,1] <- summary(elev.sf)$r.squared
  r.sqs[i,2] <- summary(elev.base)$r.squared 
}

r.sq.inc <- r.sqs[,1] - r.sqs[,2]
qqnorm(r.sq.inc, pch=20)
qqline(r.sq.inc)
mean(r.sq.inc)

# Auto-binomial 
fp <- pr.farm$irr_farms_07/pr.farm$nofarms_07
fp.col <- cbind(pr.farm$irr_farms_07, pr.farm$nofarms_07-pr.farm$irr_farms_07)
rain <- pr.farm$rain_mean

i <- 2
y.i <- pr.farm$irr_farms_07
y.i[i] <- 0 
wy <- lag.listw(pr.listw, y.i)
y <- fp.col
y[i,] <- pr.farm$nofarms_07[i]/2
iv <- rep(0,n)
iv[i] <- -1 
cimp <- get.cimp(i, pr.listw)

ab.s1 <- glm(y ~ wy + rain + iv + cimp, family=binomial)
appimp <- iv + ab.s1$coefficient["wy"]*cimp
ab.s2 <- glm(y ~ wy + rain + appimp, family=binomial)

inv.logit(ab.s2$coefficient["appimp"])


# ESF binomial

eb.base <- glm(fp.col ~ rain, family=binomial)
summary(lm(fp~eb.base$fitted.values))$r.squared

i <- 1
y[i,] <- pr.farm$nofarms_07[i]/2
iv <- rep(0,n) 
iv[i] <- -1

fp.full <- glm(y ~ rain + iv + ., data=EV, family=quasibinomial)
disp <- summary(fp.full)$dispersion
fp.sf <- stepAIC(glm(y ~ rain + iv, data=EV, family=binomial), scale=disp,  
                 scope=list(upper=fp.full), direction="forward", trace=0)
summary(fp.sf)

sel.ev <- c(2,4,9,10,12,14,16,17)
sel <- as.matrix(EV[,sel.ev])
fp.sf <- glm(fp.col ~ rain + iv + sel, family=binomial)

library(dispmod)
fp.sf.w <- glm.binomial.disp(fp.sf)
inv.logit(fp.sf.w$coefficient[3])
fp[i]


# ESF Poisson
irr.07 <- pr.farm$irr_farms_07
irr.base <- glm(irr.07 ~ rain, offset=log(pr.farm$area), family=quasipoisson)

i <- 1
iv <- rep(0,n) 
irr.07[i] <- 1
iv[i] <- -1
xyEV <- as.data.frame(cbind(irr.07, rain, EV))

irr.full <- glm(irr.07 ~ rain + iv + ., data=EV, offset=log(pr.farm$area), family=quasipoisson)
irr.sf <- stepAIC(glm(irr.07 ~ rain + iv, data=EV, offset=log(pr.farm$area), family=poisson),  
                  scope=list(upper=irr.full), direction="forward", trace=0)

sel.ev <- names(irr.sf$coefficients)[4:10]
sel <- as.matrix(EV[,sel.ev])
irr.sf <- glm(irr.07  ~ rain + iv + sel, offset=log(pr.farm$area), family=poisson)
pr.farm$irr_farms_07[i]/pr.farm$area[i]
exp(irr.sf$coefficients[3])/pr.farm$area[i]