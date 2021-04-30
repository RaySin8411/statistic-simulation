#Obtain E(N) via simulation.
#N:=min{n:sigma Ui>1},where u~(0,1)

R3.12=function(k)
   {
     N=rep(NA, k)
     for(i in 1:k)
       {
         sum.U=0; n=0
         repeat
           {
             sum.U=sum.U+runif(1); n=n+1;
             if(sum.U > 1) break
             }
         N[i]=n
         }
     cat("E(N)=", sum(N)/k, "; k=", k, "\n")
     }
 R3.12(10^2); R3.12(10^3); R3.12(10^4); R3.12(10^5)