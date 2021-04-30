#include<iostream>
#include<cmath>
#include"uniform_0_1.h"
#include<iomanip>
using namespace std;
int main(int argc,char** argv){
	Rstart(1,2,3,4);
	double obs;
	double uni;
	double lamda;
	int i,j;
	const int max_i = 1000;  
	int n;
	int sum1=0;
	int sum2=0;
	double sum3=0;
	double P = exp(-lamda);
	double mean,var;
	cout<<"½Ð¿é¤Jn,lamda­È : ";
	cin>>n>>lamda;
for(j=0;j<n;j++)
{
	P = exp(-lamda);
	uni= Uni();	 
    sum3=P;
	if (sum3>=uni) obs=0;
	else {
	for(i=1;i<max_i;i++)	
	{	
	  	P*=lamda/double(i);            //Calc next prob
    	sum3+=P; 					//Increase cumulant                      
      if (sum3>=uni)  
	  {	
		obs=i;
		break;
	  } 
	}
 	}
sum1=obs+sum1;
sum2=obs*obs+sum2;
//cout<<setw(20)<<obs<<setw(20)<<sum1<<setw(20)<<sum2<<endl;
}
mean=double(sum1)/double(n);
var=double(sum2)/double(n)-mean*mean;
cout<<"mean: "<<mean<<endl;
cout<<"var: "<<var<<endl;
return 0;
} 
