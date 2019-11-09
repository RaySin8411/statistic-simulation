#include<iostream>
#include <iomanip>
#include<cmath>
using namespace std;

int main (int argc,char** argv){
	int x[200];	
	double sum,var,sig;
	
	int i,j,k;
	for(j=0;j<200;j++)
	{
		x[j]=j+1;
	}	
	sum=0;
	for(j=0;j<200;j++)
	{
		if (j==0){
			sum=pow(x[j],2)*pow(x[j],100)/pow(200,100);
		}
		else sum=sum+pow(x[j],2)*(pow(x[j],100)-pow(x[j-1],100))/pow(200,100);		
	cout<<sum<<endl;
	}
	var=sum;
	sig=sqrt(var);
	cout<<var<<endl;
	cout<<sig<<endl;
	return 0;
	} 
