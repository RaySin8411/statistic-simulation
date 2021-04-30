rm(list=ls())
set.seed(2012)
Rejection.method = function(n, x, p, q){
   c = max(p/q);
   X = rep(0,n);
   for(i in 1:n){
     repeat{
       U1 = runif(1);
       Y = as.integer(length(x)*U1)+1;
       U2 = runif(1);
       if(U2<=p[Y]/(c*q[Y])){X[i]=Y; break;}
       }
     }
   true.mean = sum(x*p);
   return(c(sample.mean=mean(X),true.mean=true.mean))
   }

 x=1:10
 p = c(0.11, 0.12, 0.09, 0.08, 0.12, 0.10, 0.09, 0.09, 0.10, 0.10);
 q = rep(0.1,10)
 Rejection.method(1000,x,p,q)