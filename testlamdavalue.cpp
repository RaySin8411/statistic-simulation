#include<iostream>
#include<cmath>
#include"uniform_0_1.h"
#include<iomanip>

using namespace std;
int main(int argc,char** argv){
	Rstart(1,2,3,4);
	double lamda[200];
	int n,i,j,k,obs,sum1,sum2,P;
	const int max_i=1000;
	double uni,mean,var,sum3;
	
	
for(i=0;i<20;i++)
{
	lamda[i]=(i+1)/20.0;
	cout<<lamda[i]<<endl;
}
n=1;

for(j=0;j<20;j++)
{
for(k=0;k<n;k++)
{
	P = exp(-lamda[j]);
	uni= Uni();	 
    sum3=P;
	if (sum3>=uni) obs=0;
	else {
	for(i=1;i<max_i;i++)	
	{	
	  	P*=lamda[j]/double(i);            //Calc next prob
    	sum3+=P; 					//Increase cumulant                      
      if (sum3>=uni)  
	  {	
		obs=i;
		break;
	  } 
	}
 	}
 	 cout<<obs<<endl;	
sum1=obs+sum1;
sum2=obs*obs+sum2;
} 
mean=double(sum1)/double(n);
var=double(sum2)/double(n)-mean*mean;
cout<<"n: "<<n<<endl;
cout<<"mean: "<<mean<<endl;
cout<<"var: "<<var<<endl;
}

return 0;
}
