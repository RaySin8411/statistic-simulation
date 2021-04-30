rm(list=ls())
set.seed(2012)

search.time=function(lambda=5,sim=100){
  search.t=rep(0,sim)
  X=rep(0,sim)
  for(j in 1:sim){
    i=1;p=exp(-lambda)*5/(1-exp(-5));F=p;
    U=runif(1)
    repeat{
      search.t[j] = search.t[j]+1;
      if(U<F) {X[j]=i;break;} else{
        p = p*lambda/(i+1);
        F = F+p;
        i=i+1
      }
    }
  }
  return(c(mean(X),var(X)))
}
search.time(sim=10000)
