#include<iostream>
#include"uniform_0_1.h"
using namespace std;
int main (int argc,char** argv){
	Rstart(1,2,3,4);
	double uni= Uni();
	int x1=1,x2=2,x3=3;
	int obs;
	
if (uni<=0.33) obs=x1;
else if (uni<=0.66&&uni>0.33) obs=x2; 
else if (uni>0.66 )obs=x3;


	cout<<uni<<endl;
		cout<<obs<<endl;
return 0;
} 

