
rm(list=ls())
 set.seed(13)
 permu = function(x){
   y = x;
   k=length(x);
   repeat{
     z=runif(1)
     I = as.integer(k*z)+1
     print(I)
     y[c(I,k)] = x[c(k,I)];
     x=y
     k = k-1;
     if(k==1) break;
     }
   return(y);
   }
 print(permu(c(3,2,8,9)))
 # There is an alternative to do
 # the same thing by "sample(c(3,2,8,9))" 