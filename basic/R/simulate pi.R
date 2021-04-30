evalpi=function(K){
  I=0;k=0;
  for(k in 1:K)
  {
  U1=runif(1)
  U2=runif(1)
  X=2*U1-1
  Y=2*U2-1
  if (X^2+Y^2<=1){I=I+1}
  if (k==K){p=I/K;break}
  }
    return(4*p)
}
evalpi(10000)
