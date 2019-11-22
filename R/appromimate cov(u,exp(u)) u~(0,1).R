#simulation to approximate Cov(U,exp(U)),where U~U(0,1)
R3.10=function(n)
   {
     x=runif(n); y=exp(x)
     cat("k=", n, "; Cov(U, e.u)=", cov(x, y), "\n")
     a=integrate(function(u){u*exp(u)}, lower=0, upper=1)$value
     b=integrate(function(u){u}, lower=0, upper=1)$value
     c=integrate(function(u){exp(u)}, lower=0, upper=1)$value
     cat("The exact value=", a-b*c, "Error=", cov(x, y)-(a-b*c), "\n")
    0 }
 R3.10(10^3)
 R3.10(10^4)
 R3.10(10^5)