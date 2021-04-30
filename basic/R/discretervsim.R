rm(list=ls())
 set.seed(2012)
 discrete.rv.sim=function(x=c(1,2,3),p=c(1/2,1/3,1/6),n=500)
   {
     support.n = length(x)
     y = rep(0,n) # or using rep(NA,n)
     for(j in 1:n)
       {
         u=runif(1)
         y.index=support.n-sum(u<cumsum(p))+1
         y[j]=x[y.index]
         }
     y.mean=mean(y)
     t.mean=sum(x*p)
     y.var=var(y)
     t.var=sum((x-t.mean)^2*p)
     return(c(sample.mean=y.mean,true.mean=t.mean,sample.var=y.var,true.var=t.var))
     }
 print(discrete.rv.sim(x=c(1,2,3,4,5,6,7),p=rep(1/7,7),n=1000))