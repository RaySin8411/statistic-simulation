#CH4 P.41
Ans4.14=function(n)
   {
     x=rep(0, n)
     for(i in 1: n)
       {
         u1=runif(1)
         if(u1<0.9){
           u2=runif(1)
           x[i]=floor(10*u2)+5
           }
         else{x[i]=2*floor(5*u2)+5
         }
         }
     cat("When we generate", n, "times the random variable:", "\n")
     cat("The random sample: X={", x, "}", "\n")
     cat("sample mean=", mean(x), "; sample variance=", var(x), "\n")
     }
 Ans4.14(25)