Cal.aver = function(n,sample.size){
   a.fun = function(x){
     exp(-x^2/n^2)}
   true.aver = mean(a.fun(1:n))
   X.random = as.integer(n*runif(sample.size))+1
   app.aver = mean(a.fun(X.random))
  
   return(c(true=true.aver,app=app.aver))
   }


Cal.aver(1000000,10000)
integrate(function(x) {exp(-x^2)},0,1)