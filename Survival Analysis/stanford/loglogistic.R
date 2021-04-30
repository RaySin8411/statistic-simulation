library(tidyverse)
library(survival)
library(survminer)

options(scipen = 999)

data <- read.table("STANFORD.DAT",head=F)
colnames(data) <- c("survtime","cen","age","mismatch","age^2","age^3","id","id0")

data <- data %>% mutate(age1 = ifelse(data$age>=45 & data$age<=49,1,0))
data <- data %>% mutate(age2 = ifelse(data$age<=49,0,1))

fit <- survfit(Surv(survtime, cen) ~ age1+age2, data = data)
ggsurvplot(fit, data = data, pval = F,
           legend.labs = c("¤p©ó45·³","¤j©ó49·³","45·³¨ì49·³"),
           legend.title="¦~ÄÖ¤ÀÃþ")

#fit <- survreg(Surv(survtime, cen) ~ age1+age2 , dist='loglogistic', data=data)
#summary(fit)

loglogistic <- function(par){
  data <- da
  
  b0 <- par[1]
  b  <- par[2]
  
  t <- data$survtime
  cen <- data$cen
  
  a <- exp(b0)
  f <- (a*b*t^(b-1))/(1+a*t^b)^2
  S <- 1/(1+a*t^b)
  l <- sum(log(f^cen*S^(1-cen)))
  return(-l)
}

t <- seq(0,3000,1)
S1 <- c();S2 <- c();S3 <- c()

da <- data[data$age1==0 & data$age2==0,]
fit1 <- optim(c(0.001,0.001),fn=loglogistic, hessian = TRUE, method = "Nelder-Mead")
S1 <- 1/(1+exp(fit1$par[1])*t^fit1$par[2])

da <- data[data$age1==1 & data$age2==0,]
fit2 <- optim(c(0.001,0.001),fn=loglogistic, hessian = TRUE, method = "Nelder-Mead")
S2 <-  1/(1+exp(fit2$par[1])*t^fit2$par[2])

da <- data[data$age1==0 & data$age2==1,]
fit3 <- optim(c(0.001,0.001),fn=loglogistic, hessian = TRUE, method = "Nelder-Mead")
S3 <-  1/(1+exp(fit3$par[1])*t^fit3$par[2])

a <- summary(fit)
plot(a[[2]][1:38],a[[6]][1:38],type='s',col='deep pink',xlab='t',ylab='S(t)',
     xlim=c(0,3000),ylim=c(0,1),main="loglogistic(¦U§O°t¾A)")
points(a[[2]][39:67],a[[6]][39:67],type='s',col='green')
points(a[[2]][68:95],a[[6]][68:95],type='s',col='dark blue')
points(t,S1,type='s')
points(t,S2,type='s')
points(t,S3,type='s')
legend(1600,1, c("¤p©ó45·³","45·³¨ì49·³","¤j©ó49·³"), lty=1,col=c("deep pink","dark blue","green"))


loglogistic <- function(par){
    b0 <- par[1]
    b1 <- par[2]
    b2 <- par[3]
    b  <- par[4]
  
    x1  <- data$age1
    x2  <- data$age2
    t   <- data$survtime
    cen <- data$cen
  
  a <- exp(b0+b1*x1+b2*x2)
  f <- (a*b*t^(b-1))/(1+a*t^b)^2
  S <- 1/(1+a*t^b)
  l <- sum(log(f^cen*S^(1-cen)))
  return(-l)
}
fit4 <- optim(c(0.001,0.001,0.001,0.001),fn=loglogistic, hessian = TRUE, method = "Nelder-Mead")
#estimate <- fit4$par
#std <- sqrt(diag(solve(fit4$hessian)))
#z <- estimate/std
#pvalue <- 2*(1-pnorm(abs(z)))
#table <- data.frame(estimate,std,z,pvalue)
#rownames(table) <- c("b0","b1","b2","b")
#table
t <- seq(0,3000,1)
S1 <- c();S2 <- c();S3 <- c()
S1 <-  1/(1+exp(fit4$par[1]+fit4$par[2]*0+fit4$par[3]*0)*t^fit4$par[4])
S2 <-  1/(1+exp(fit4$par[1]+fit4$par[2]*1+fit4$par[3]*0)*t^fit4$par[4])
S3 <-  1/(1+exp(fit4$par[1]+fit4$par[2]*0+fit4$par[3]*1)*t^fit4$par[4])

a <- summary(fit)
plot(a[[2]][1:38],a[[6]][1:38],type='s',col='deep pink',xlab='t',ylab='S(t)',
     xlim=c(0,3000),ylim=c(0,1),main="loglogistic(¤@°_°t¾A)")
points(a[[2]][39:67],a[[6]][39:67],type='s',col='green')
points(a[[2]][68:95],a[[6]][68:95],type='s',col='dark blue')
points(t,S1,type='s')
points(t,S2,type='s')
points(t,S3,type='s')
legend(1600,1, c("¤p©ó45·³","45·³¨ì49·³","¤j©ó49·³"), lty=1,col=c("deep pink","dark blue","green"))

