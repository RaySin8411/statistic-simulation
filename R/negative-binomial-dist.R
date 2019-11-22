Ans4.10a=function(r, p, n)
{
  X=rep(0, n)
  for(i in 1: n)
  {
    u1=runif(r)
    X[i]=sum(floor(log(u1)/log(1-p))+1)
  }
  cat("When r=", r, ", p=", p, ": mean=", r/p, ";
      10 variance=", r*(1-p)/p^2, "\n")
  cat("Generate", n, "random variables: ", "sample mean=",
      mean(X), "; sample variance=", var(X), "\n")
}
Ans4.10a(18, 0.6, 1000)
Ans4.10a(5, 0.2, 10000)