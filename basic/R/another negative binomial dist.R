Ans4.10c=function(r,p,n)
{
  Y=rep(0,n)
  for(i in 1:n)
  {
    u2=runif(1)
    j=r;pr=p^r;F=pr
    if(u2<F){Y[i]=j}
  else{
          repeat{
            pr=(j*(1-p)/(j-r+1))*pr
            j=j+1;F=F+pr
            if(u2<F) break
          }
    Y[i]=j
  }
    }

cat("When r=", r, ", p=", p, ": mean=", r/p, ";
      variance=", r*(1-p)/p^2, "\n")
 cat("Generate", n, "random variables: ", "sample mean=",
      mean(Y), "; sample variance=", var(Y), "\n")
}

Ans4.10c(18,0.6,1000)
