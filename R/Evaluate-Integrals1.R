# evaluate exp(x+x^2) from -2 to 2
R3.5=function(n)
{
  y=runif(n)
  h.y=4*exp((4*y-2)+(4*y-2)^2)
  Int.app=mean(h.y)
  cat("k=",n,",the approximate intrgral=",Int.app,"\n")
# exact value
  f=function(x){exp(x+x^2)}
  Int.exact=integrate(f,lower=-2,upper = 2)$value
  cat("The exact intrgral=",Int.exact,"; error=",
      Int.app-Int.exact,"\n")
}
R3.5(10^3)
R3.5(10^4)
R3.5(10^5)