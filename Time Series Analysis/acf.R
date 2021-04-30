acf.me<-function(da,lag,type)
{
  
  T=length(da);r=da;r.bar=mean(r);r.square=(r-r.bar)^2;
  rhat.var=sum(r.square);r.hat=rep(0,times=lag+1);
  lo.hat=rep(0,times=lag+1);
  k.vector=rep(0,times=lag+1);
  for (k in 0:lag)
  {
    sum1=0;
    for (t in 1:(T-k)) 
    {
      sum1=sum1+(r[t]-r.bar)*(r[t+k]-r.bar);
    }
    r.hat[k+1]=sum1/T;
    lo.hat[k+1]=sum1/rhat.var;
    k.vector[k+1]=k
  }
  m=cbind(k.vector,r.hat,lo.hat);
  colnames(m)=c('k','cov','cor');
  if(type=="cov")
    return(m[,1:2])
  else if (type=="cor")
    return(cbind(m[,1],m[,3]))
  else
    return(m)
}