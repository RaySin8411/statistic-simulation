rmultinom1=function(n,p1,p2,sim){
  X=rep(0:sim)
  for(k in 1:sim){
    repeat{
        x1=0;pr1=(1-p1)^n;F1=pr1
        U=runif(1)
        repeat{
        if (U<F1) {
        x1=x1;break;}
    
        pr1=p1/(1-p1)*(n-x1)/(x1+1)*pr1;F1=F1+pr1;
        x1=x1+1
    
        }
    x2=0;pr2=(1-p2)/(1-p1)^(n-x1);F2=pr2
    V=runif(1)
    if(V<F2){
      x2=x2
      X[k]=x2;break;}
      pr2=p2/(1-p2)*(n-x1-x2)/(x2+1)*pr2;F2=F2+pr2;
      x2=x2+1
    }
  }
  return(c(mean(X),var(X)))
}
