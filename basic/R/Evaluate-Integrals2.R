#evaluate exp(-x^2) from -infinte to infinte
R3.7=function(n)
{
  y=runif(n)
  h.y=2*exp(-(1/y-1)^2)/y^2
  Int.app=mean(h.y)
  cat("k=",n,", the approximate integral=",Int.app,"\n")
#exact value
  f=function(x){exp(-x^2)}
  Int.exact=integrate(f,lower=-Inf,upper = Inf)$value
  cat("The exact integral=",Int.exact,"; 
      error=",Int.app-Int.exact,"\n")
}
R3.7(10^3)
R3.7(10^4)
R3.7(10^5)