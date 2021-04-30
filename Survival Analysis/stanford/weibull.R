library(tidyverse)
library(survival)
library(survminer)

data <- read.table("STANFORD.DAT",head=F)
colnames(data) <- c("survtime","cen","age","mismatch","age^2","age^3","id","id0")

data <- data %>% mutate(age1 = ifelse(data$age>=45 & data$age<=49,1,0))
data <- data %>% mutate(age2 = ifelse(data$age<=49,0,1))

fit1 <- survfit(Surv(survtime, cen) ~ age1+age2, data = data)

weibull <- function(par){
  b0 <- par[1]
  b1 <- par[2]
  b2 <- par[3]
  b  <- par[4]
  
  x1  <- data$age1
  x2  <- data$age2
  t   <- data$survtime
  cen <- data$cen
  
  a <- exp(b0+b1*x1+b2*x2)
  f <- a*b*t^(b-1)*exp(-a*t^b)
  S <- exp(-(a*t^b))
  l <- sum(log(f^cen*S^(1-cen)))
  return(-l)
}


fit <- optim(c(0.001,0.001,0.001,0.001),fn=weibull, hessian = TRUE, method = "Nelder-Mead")
fit$par

#fit2 <- survreg(Surv(survtime, cen) ~ age1+age2 , dist='weibull', data=data)
#summary(fit2)

t <- seq(0,3000,1)
S1 <- c();S2 <- c();S3 <- c()
S1 <- exp(-(exp(fit$par[1]+fit$par[2]*0+fit$par[3]*0)*t^fit$par[4]))
S2 <- exp(-(exp(fit$par[1]+fit$par[2]*1+fit$par[3]*0)*t^fit$par[4]))
S3 <- exp(-(exp(fit$par[1]+fit$par[2]*0+fit$par[3]*1)*t^fit$par[4]))

a <- summary(fit1)
plot(a[[2]][1:38],a[[6]][1:38],type='s',col='deep pink',
     xlim=c(0,3000),ylim=c(0,1),xlab='t',ylab='S(t)',main="weibull(�@�_컏퐸)")
points(a[[2]][39:67],a[[6]][39:67],type='s',col='green')
points(a[[2]][68:95],a[[6]][68:95],type='s',col='dark blue')
points(t,S1,type='s')
points(t,S2,type='s')
points(t,S3,type='s')
legend(1600,1, c("쨛⒀45럼","45럼⑥49럼","쨓⒀49럼"), lty=1,col=c("deep pink","dark blue","green"))

