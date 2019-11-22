rm(list=ls())
 set.seed(2012)

 integer.rv = function(n=10,sim=100){
   X = as.integer(runif(sim)*n)+1;
   return(c(true.mean = (n+1)/2,sample.mean=mean(X),
              true.var = (n^2-1)/12,sample.var = var(X)))
   }
 integer.rv(sim=1000)