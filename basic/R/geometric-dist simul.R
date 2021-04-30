rm(list=ls())
 set.seed(2012)

 geometric.rv = function(p=.5,n=100){
   q = 1-p;
   X = as.integer(log(runif(n))/log(q))+1;
   return(c(true.mean = 1/p,sample.mean=mean(X),
              true.var = q/p^2,sample.var = var(X)))
   }
 geometric.rv(p=0.2,n=1000000)