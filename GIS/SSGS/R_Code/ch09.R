setwd("C:\\ssgs")

# 9.2.1

### Normal ###
source("all_functions.R")
# Normal 5x5 case
n <- 5
n.sim <- 10000
EV <- gen.ev.square(n, 0.25)
r.norm <- sapply(1:n.sim, function(x, n) {rnorm(n^2)}, n=n)

sim.n.5 <- matrix(NA, n.sim, 2)
colnames(sim.n.5) <- c("# of EV","r.sq")
for (i in 1:n.sim){
  y <- r.norm[,i]
  lm.full <- lm(y ~ ., data=EV)
  lm.i <- stepwise.forward(lm.full, lm(y ~ 1, data=EV), 0.01, verbose=F)
  sim.n.5[i,] <- c(lm.i$rank-1, summary(lm.i)$r.squared)
}
summary(sim.n.5)
sum(sim.n.5[,1]==0)/n.sim

# Normal 25x25 case
n <- 25
n.sim <- 10000
EV <- gen.ev.square(n, 0.25)
r.norm <- sapply(1:n.sim, function(x, n) {rnorm(n^2)}, n=n)

sim.n.25 <- matrix(NA, n.sim, 2)
colnames(sim.n.25) <- c("# of EV","r.sq")
for (i in 1:n.sim){
  y <- r.norm[,i]
  lm.full <- lm(y ~ ., data=EV)
  lm.i <- stepwise.forward(lm.full, lm(y ~ 1, data=EV), 0.01, verbose=F)
  sim.n.25[i,] <- c(lm.i$rank-1, summary(lm.i)$r.squared)
}
summary(sim.n.25)
sum(sim.n.25[,1]==0)/n.sim


# 9.2.2
n.sim <- 10000
# Normal 5x5 case 1%
sim.n.5.1p <- sim.sf.norm (n=5, n.sim, mc=0.76)
summary(sim.n.5.1p)
sum(sim.n.5.1p[,1]==0)/n.sim

# Normal 5x5 case 5%
sim.n.5.5p <- sim.sf.norm (n=5, n.sim, mc=0.85)
summary(sim.n.5.5p)
sum(sim.n.5.5p[,1]==0)/n.sim

# Normal 5x5 case 10%
sim.n.5.5p <- sim.sf.norm (n=5, n.sim, mc=0.90)
summary(sim.n.5.10p)
sum(sim.n.5.10p[,1]==0)/n.sim

# Normal 25x25 case 1%
sim.n.25.1p <- sim.sf.norm (n=25, n.sim, mc=0.76)
summary(sim.n.25.1p)
sum(sim.n.25.1p[,1]==0)/n.sim

# Normal 25x25 case 5%
sim.n.25.5p <- sim.sf.norm (n=25, n.sim, mc=0.85)
summary(sim.n.25.5p)
sum(sim.n.25.5p[,1]==0)/n.sim

# Normal 25x25 case 10%
sim.n.25.5p <- sim.sf.norm (n=25, n.sim, mc=0.90)
summary(sim.n.25.10p)
sum(sim.n.25.10p[,1]==0)/n.sim

# Normal 35x35 case 1%
sim.n.35.1p <- sim.sf.norm (n=35, n.sim, mc=0.76)
summary(sim.n.35.1p)
sum(sim.n.35.1p[,1]==0)/n.sim

# Normal 35x35 case 5%
sim.n.35.5p <- sim.sf.norm (n=35, n.sim, mc=0.85)
summary(sim.n.35.5p)
sum(sim.n.35.5p[,1]==0)/n.sim

# Normal 35x35 case 10%
sim.n.35.10p <- sim.sf.norm (n=35, n.sim, mc=0.90)
summary(sim.n.35.10p)
sum(sim.n.35.10p[,1]==0)/n.sim