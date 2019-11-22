# R function for generating multinomial random numbers (Case I)
rmultinom = function (sim, size, prob)
{
  K = length(prob);
  sample.matrix = matrix(0,ncol=K,nrow=sim);
  for(i in 1:sim){
    for(j in 1:size){
      u = runif(1);
      cell.index = K-sum(u<cumsum(prob))+1;
      sample.matrix[i,cell.index] =
        sample.matrix[i,cell.index]+1;
    }# loop for j
  }# loop for i
  return(apply(sample.matrix,2,mean))
}

rmultinom(100000, 10, c(0.1, 0.2, 0.3, 0.4))