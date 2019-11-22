rm(list=ls()); set.seed(2012);

 mix.pdf = function(x,a,mu,sigma){
   a=a; mu=mu; sigma=sigma;
   #sum(a*c(dnorm(x,0,1),dnorm(x,5,1),dnorm(x,10,1))) #does not work
   # not an efficient way for the following case
   #a[1]*dnorm(x,0,1)+a[2]*dnorm(x,5,1)+a[3]*dnorm(x,10,1);
   # It works for the case below but not an efficient way.
   #as.vector(cbind(dnorm(x,0,1),dnorm(x,5,1),dnorm(x,10,1))%*%matrix(a,ncol=1))
   normal.matrix = NULL
   for (i in 1:length(a)) {
     normal.matrix = cbind(normal.matrix,dnorm(x,mu[i],sigma[i]));}
   as.vector(normal.matrix%*%matrix(a,ncol=1) )
   }
main = function(n=100,a,mu,sigma){
   a=a; mu=mu; sigma=sigma;
   X = rep(0,n);
   for(i in 1:n){
     uni = runif(1);
     ind = length(a)-sum(uni<cumsum(a))+1; #component.index
     X[i] = rnorm(1,mu[ind],sigma[ind]);
     } # for loop i
   hist(X,freq=F,breaks=60);
   curve(mix.pdf(x,a,mu,sigma),from=min(X),to=max(X),add=T,col="red")
   curve(dnorm(x,0,1)*a[1],from=min(X),to=max(X),add=T,col="blue")
   curve(dnorm(x,5,1)*a[2],from=min(X),to=max(X),add=T,col="green")
   } # End for the main function

 a=c(1/3,1/3,1/3); mu = c(0,5,10); sigma = c(1,1,1);
 main(n=10000,a,mu,sigma)