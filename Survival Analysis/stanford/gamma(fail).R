library(tidyverse)
library(survival)
library(survminer)

data <- read.table("STANFORD.DAT",head=F)
colnames(data) <- c("survtime","cen","age","mismatch","age^2","age^3","id","id0")

data <- data %>% mutate(age1 = ifelse(data$age>=45 & data$age<=49,1,0))
data <- data %>% mutate(age2 = ifelse(data$age<=49,0,1))

fit1 <- survfit(Surv(survtime, cen) ~ age1+age2, data = data)

ga <- function(par){
  data <- da
  b0 <- par[1]
  b <- par[2]
  #  b1 <- par[2]
  #  b2 <- par[3]
  #  b <- par[4]
  
  #  x1 <- data$age1
  #  x2 <- data$age2
  t <- data$survtime
  cen <- data$cen
  
  a <- b0#+b1*x1+b2*x2
  f <- (a*(a*t)^(b-1)*exp(-a*t))/gamma(b)
  integrand <- function(x) {(a*(a*x)^(b-1)*exp(-a*x))/gamma(b)}
  S <- integrate(integrand, lower = t, upper = Inf)$value
  l <- sum(log(f^cen*S^(1-cen)))
  return(-l)
}

t <- seq(0,3000,1)
S1 <- c();S2 <- c();S3 <- c()

da <- data[data$age1==0 & data$age2==0,]
fit <- optim(c(0.001,0.001),fn=ga, hessian = TRUE, method = "Nelder-Mead")
fit$par
S1 <- 1/(1+fit$par[1]*t^fit$par[2])

da <- data[data$age1==1 & data$age2==0,]
fit <- optim(c(0.001,0.001),fn=ga, hessian = TRUE, method = "Nelder-Mead")
fit$par
S2 <-  1/(1+fit$par[1]*t^fit$par[2])

da <- data[data$age1==0 & data$age2==1,]
fit <- optim(c(0.001,0.001),fn=ga, hessian = TRUE, method = "Nelder-Mead")
fit$par
S3 <-  1/(1+fit$par[1]*t^fit$par[2])

a <- summary(fit1)
plot(a[[2]][1:38],a[[6]][1:38],type='s',col='deep pink',xlim=c(0,3000),ylim=c(0,1),
     main="loglogistic(各別配適)")
points(a[[2]][39:67],a[[6]][39:67],type='s',col='green')
points(a[[2]][68:95],a[[6]][68:95],type='s',col='dark blue')
points(t,S1,type='s')
points(t,S2,type='s')
points(t,S3,type='s')

ga <- function(par){
  b0 <- par[1]
  b1 <- par[2]
  b2 <- par[3]
  b <- par[4]
  
  x1 <- data$age1
  x2 <- data$age2
  t <- data$survtime
  cen <- data$cen
  
  a <- b0+b1*x1+b2*x2
  f <- (a*(a*t)^(b-1)*exp(-a*t))/gamma(b)
  integrand <- function(x) {(a*(a*x)^(b-1)*exp(-a*x))/gamma(b)}
  S <- integrate(integrand, lower = t, upper = Inf)$value
  l <- sum(log(f^cen*S^(1-cen)))
  return(-l)
}
fit <- optim(c(0.001,0.001,0.001,0.001),fn=ga, hessian = TRUE, method = "Nelder-Mead")
estimate <- fit$par
std <- sqrt(diag(solve(fit$hessian)))
z <- estimate/std
pvalue <- 2*(1-pnorm(abs(z)))
table <- data.frame(estimate,std,z,pvalue)
rownames(table) <- c("b0","b1","b2","b")
table

t <- seq(0,3000,1)
S1 <- c();S2 <- c();S3 <- c()
S1 <-  1/(1+(fit$par[1]+fit$par[2]*0+fit$par[3]*0)*t^fit$par[4])
S2 <-  1/(1+(fit$par[1]+fit$par[2]*1+fit$par[3]*0)*t^fit$par[4])
S3 <-  1/(1+(fit$par[1]+fit$par[2]*0+fit$par[3]*1)*t^fit$par[4])

a <- summary(fit1)
plot(a[[2]][1:38],a[[6]][1:38],type='s',col='deep pink',xlim=c(0,3000),ylim=c(0,1),main="loglogistic(一起配適)")
points(a[[2]][39:67],a[[6]][39:67],type='s',col='green')
points(a[[2]][68:95],a[[6]][68:95],type='s',col='dark blue')
points(t,S1,type='s')
points(t,S2,type='s')
points(t,S3,type='s')
