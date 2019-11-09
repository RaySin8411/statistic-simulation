#include<iostream>
#include<cmath>
#include"uniform_0_1.h"
#include<iomanip>

using namespace std;
int main(int argc,char** argv){
	Rstart(1,2,3,4);
	double obs;
	double lambda=5;
	double uni;
	cout<<setw(10)<<"uniform rv"<<" "<<setw(5)<<"x"<<endl;
	cout<<"-------------------"<<endl;
	int i;
for(i=0;i<5;i++)	
{
  uni= Uni();
  obs=-log(1- uni) / lambda;
cout<<setw(10);
	cout<<uni<<"     "<<obs<<" "<<endl;
}
return 0;
} 

