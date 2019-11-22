//(y1,y2,y3) 三項分配
//given y2 =200 下 y1是 binomial(800,1/2) 

#include<iostream>
#include<cmath>
#include"uniform_0_1.h"
#include <iomanip>
using namespace std;

int main (int argc,char** argv){
	Rstart(1,2,3,8); //灑種子 (設初始位置) 
	double average,bias,mean,sigma;
	int count1=0,count2=0,count3=0; //計數器 
	int sum1=0,sum2=0;//累加器 
	int i,n;
	double uni;
	
	n=500; //模擬次數 
	for(i = 0 ; i < n ; i++){
		count1 = 0;
		count3 = 0;
		while(count1 + count3 < 800){
			uni= Uni();
  			if (uni<=(1./3.)) count1+=1;
			else if (uni<=(2./3.)&&uni>(1./3.)) count2+=1; 
			else if (uni>(2./3.) )count3+=1;
		}
		cout<<"第"<<i+1<<"次試驗:"<<setw(5)<<"Y_1:"<<count1<<setw(5)<<"Y_3:"<<count3<< endl;
		sum1 += count1;
		sum2 += pow(count1,2);
	}
	cout<<"-------------------------------------------------"<<endl;
	average = sum1/double(n);
	mean = 400;
	bias = average - mean;
	sigma = sqrt((sum2-n*pow(average,2))/double(n));
	
	cout<<"mean:"<<mean<<endl;
	cout<<"average:"<<average<<endl;
	cout<<"bias:"<<bias<<endl;
	cout<<"simple sigma:"<<sigma<<endl;
	
	
	return 0;
} 
