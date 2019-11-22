#include<iostream>
#include"uniform_0_1.h"
#include <iomanip>
#include<cmath>
using namespace std;

int main (int argc,char** argv){
	Rstart(1,2,3,4);
	int x1=0,x2=1;	
	int obs;
	int i_max=1000;
	double uni,p;
	//cout<<setw(10)<<"uniform rv"<<" "<<setw(5)<<"x"<<endl;
	//cout<<"-------------------"<<endl;
	int i;
for(i=0;i<i_max;i++)	
{
  uni= Uni();
  if (uni<=(1./2.)) obs=x1; 
else if (uni>(1./2.) )obs=x2;
//cout<<setw(10);
//cout<<uni<<"     "<<obs<<" "<<endl;

p=pow(2,i);
}
return 0;
} 

