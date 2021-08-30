library(spdep)
library(classInt)
library(maptools)

setwd("C:\\Users\\15239\\Desktop\\course_related\\SpatialStatisticsAndGeostatistics\\SSGdata")
pr <- readShapePoly("PuertoRico.shp", proj4string=CRS("+proj=longlat +ellps=WGS84"))

pr.f <- read.csv(file="PR-farm-data.csv")
pr.nb <- read.gal("PuertoRico.GAL")
pr.listw <- nb2listw(pr.nb, style="W")
pr.listb <- nb2listw(pr.nb, style="B")

# 6.2
f.den02 <- pr.f$cuerdas_02/pr.f$area
f.d.sar <- errorsarlm(f.den02 ~ 1,   
                      listw=pr.listw)
f.d.sar$lambda

z <- c(1.65, 1.96)
zc <- c(2.8284, 3.0471)
fc <- c(3.1845, 3.4920) 
bf <- c(3.2009, 3.3955) 

f.Ii <- localmoran(f.den02, pr.listb)
zIi <- f.Ii[,"Z.Ii"]
mx <- max(zIi)
mn <- min(zIi)

# Mapping significance for z-scores
pal <- c("white", "red1", "red4")
z3.Ii <- classIntervals(zIi, n=3, style="fixed", fixedBreaks=c(mn, z, mx))
cols.Ii <- findColours(z3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(z3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")              

# Mapping significance for adjusted z-scores               
zc3.Ii <- classIntervals(zIi, n=3,    
                         style="fixed", fixedBreaks=c(mn, zc, mx))
cols.Ii <- findColours(zc3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(zc3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")

# Mapping significance for adjusted t statistics
fc3.Ii <- classIntervals(zIi, n=3,   
                         style="fixed", fixedBreaks=c(mn, fc, mx))
cols.Ii <- findColours(fc3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(fc3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")

# Mapping significance for Bonferroni adjustment
bf3.Ii <- classIntervals(zIi, n=3, 
                         style="fixed", fixedBreaks=c(mn, bf, mx))
cols.Ii <- findColours(bf3.Ii, pal)  
plot(pr, col=cols.Ii)
brks <- round(bf3.Ii$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, legend=leg, bty="n")


#6.3
pr.nb.s <- include.self(pr.nb)

pr.listb.s <- nb2listw(pr.nb.s,style="B")
f.Gi <- localG(f.den02, pr.listb.s)

pal.rb <- c("blue","white","red","red4")
z4.Gi <- classIntervals(f.Gi, n=4, style="fixed", fixedBreaks=c(min(f.Gi), -zc[1], zc[1], zc[2], max(f.Gi)))
cols.Gi <- findColours(z4.Gi, pal.rb)               
plot(pr, col=cols.Gi)
brks <- round(z4.Gi$brks,4)
leg <- paste(brks[-5], brks[-1], sep=" - ")
legend("bottomright", fill= pal.rb, legend=leg, bty="n")

t3.Gi <- classIntervals(f.Gi, n=3, 
                        style="fixed", fixedBreaks=c(min(f.Gi), 
                                                     fc[1], fc[2], max(f.Gi)))
cols.Gi <- findColours(t3.Gi, pal)               
plot(pr, col=cols.Gi)
brks <- round(t3.Gi$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill=pal, 
       legend=leg, bty="n")

#6.4
z.f <- scale(f.den02)
ur.c <- ifelse(pr.f$u_r==1,1,-1)

evec <- read.table("pr_evecs.txt",header=T)
EV <- evec[,-(1:2)]
sEV <- cbind(EV, ur.c * EV)
colnames(sEV) <- c(colnames(EV), 
                   paste("xEV", 1:NCOL(EV), sep=""))

sv.full <- lm(z.f ~ ur.c + ., data=sEV)
sv.sf <- stepAIC(lm(z.f ~ ur.c, data=sEV), scope=list(upper=sv.full), direction="forward")
summary(sv.sf)

# The selected model in the text
sv.sf <- lm(z.f ~ ur.c + EV10 + xEV8 + EV1 + xEV1 + EV3 + EV12 + EV9, data=sEV)         
summary(sv.sf)

attach(sEV)
sv.int <- 0.0052 + 3.0909*EV1 - 1.4900*EV3 - 1.2975*EV9 + 3.0649*EV10 + 1.4365*EV12 
sv.slp <- -0.2579 + 2.3006*xEV1 + 2.4197*xEV8 
detach(sEV)

summary(sv.int)
summary(sv.slp)

pal.rb3 <- c("blue","white","red")
f3.int <- classIntervals(sv.int, n=3,   
                         style="fixed", fixedBreaks=c(min(sv.int), 
                                                      -0.6, 0.6, max(sv.int)))
cols.int <- findColours(f3.int, pal.rb3)               
plot(pr, col=cols.int)
brks <- round(f3.int$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill= pal.rb3, legend=leg, bty="n")

f3.slp <- classIntervals(sv.slp, n=3, 
                         style="fixed", fixedBreaks=c(min(sv.slp), 
                                                      -0.4, 0.4, max(sv.slp)))
cols.slp <- findColours(f3.slp, pal.rb3)               
plot(pr, col=cols.slp)
brks <- round(f3.slp$brks,4)
leg <- paste(brks[-4], brks[-1], sep=" - ")
legend("bottomright", fill= pal.rb3, 
       legend=leg ,bty="n")

plot(sv.slp, sv.int, pch=20)
cor(sv.slp,sv.int)