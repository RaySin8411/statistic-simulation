#include<iostream>
#include<cmath>
#include"uniform_0_1.h"
#include <iomanip>
using namespace std;

int main (int argc,char** argv){
	Rstart(1,2,3,8); //灑種子 (設初始位置) 
	double x1_p,x2_p,x3_p,mean,var;
	int x1=1,x2=2,x3=3;	
	int sum1=0,	sum2=0,sum3=0; //計數器 
	int obs;
	double uni;
	cout<<setw(5)<<"x"<<setw(5)<<"幾個"<<setw(7)<<"比例"<<endl;
	cout<<"-------------------"<<endl;
	int i;
	
	for(i=0;i<1000;i++)	
	{
  		uni= Uni();
  		if (uni<=(1./3.)) sum1+=1;
		else if (uni<=(2./3.)&&uni>(1./3.)) sum2+=1; 
		else if (uni>(2./3.) )sum3+=1;
	}	
	
	x1_p=sum1/1000.;
	x2_p=sum2/1000.;
	x3_p=sum3/1000.;
	
	mean=x1_p*x1+x2_p*x2+x3_p*x3; //算平均 
	var=x1_p*pow(x1,2)+x2_p*pow(x2,2)+x3_p*pow(x3,2)-pow(mean,2);//算變異數 

	cout<<setw(5)<<x1<<setw(5)<<sum1<<setw(7)<<x1_p<<endl;
	cout<<setw(5)<<x2<<setw(5)<<sum2<<setw(7)<<x2_p<<endl;
	cout<<setw(5)<<x3<<setw(5)<<sum3<<setw(7)<<x3_p<<endl;
	
	cout<<"-------------------"<<endl;

	cout<<setw(5)<<"mean:"<<setw(7)<<mean<<endl;
	cout<<setw(5)<<"var:"<<setw(7)<<var<<endl;
	
	return 0;
} 
