bin=function(n,p,sim){
  X=rep(0, sim)
  for(j in 1:sim)
  {
    i=0;c=p/(1-p);pr=(1-p)^n;F=pr
    U=runif(1)
    repeat{
      if(U<F) {X[j]=i;break;} else{
          pr=c*(n-i)/(i+1)*pr;
          F=F+pr;
          i=i+1;      
      } 
    }
   }
  return(c(mean(X),var(X)))
}
bin(7,0.5,100)