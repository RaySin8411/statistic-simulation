rm(list = ls())
set.seed(2012)

search.time=function(lambda=5,sim=1000){
  search.t=rep(0,sim);
  X=rep(0,sim);
  I=as.integer(lambda);
  for(j in 1:sim){
    U=runif(1);
    i=I;F=ppois(I,lambda);p=dpois(I,lambda);
    if(U<F){
              i=i-1;F=F-p;p=p/(lambda/(i+1));
          repeat{#b
                  search.t[j]=search.t[j]+1;
                  if(U>F || i==-1){X[j]=i+1;break;}
                  else{#c
                    i=i-1;
                    F=F-p;
                    p=p/(lambda/(i+1));
                  }#C
            }#b
    }else{
          i=i+1;p=p*lambda/i;F=F+p;
          repeat{
                  search.t[j]=search.t[j]+1;
                  if(U<F){X[j]=i;break;}else{
                    i=i+1;
                    p=p*lambda/i;
                    F=F+p
                  }
          }
    }
  }
  return(c(sim=mean(search.t),EX=mean(X),varX=var(X),
       true=mean(abs(X-lambda)),appro=0.798*sqrt(lambda)))
}
search.time(lambda = 10,sim=100000)
