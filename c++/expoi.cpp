const int PoissonRandomNumber(const double lambda)
{
  int k=0;                          //Counter
  const int max_k = 1000;           //k upper limit
  double p = UniformRandomNumber(); //uniform random number
  double P = exp(-lambda);          //probability
  double sum=P;                     //cumulant
  if (sum>=p) return 0;             //done allready
  for (k=1; k<max_k; ++k) {         //Loop over all k:s
    P*=lambda/(double)k;            //Calc next prob
    sum+=P;                         //Increase cumulant
    if (sum>=p) break;              //Leave loop
  }

  return k;                         //return random number
}

