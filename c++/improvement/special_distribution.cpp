//(y1,y2,y3) �T�����t
//given y2 =200 �U y1�O binomial(800,1/2) 

#include<iostream>
#include<cmath>
#include"uniform_0_1.h"
#include <iomanip>
using namespace std;

int main (int argc,char** argv){
	Rstart(1,2,3,8); //�x�ؤl (�]��l��m) 
	double average,bias,mean,sigma;
	int count1=0,count2=0,count3=0; //�p�ƾ� 
	int sum1=0,sum2=0;//�֥[�� 
	int i,n;
	double uni;
	
	n=500; //�������� 
	for(i = 0 ; i < n ; i++){
		count1 = 0;
		count3 = 0;
		while(count1 + count3 < 800){
			uni= Uni();
  			if (uni<=(1./3.)) count1+=1;
			else if (uni<=(2./3.)&&uni>(1./3.)) count2+=1; 
			else if (uni>(2./3.) )count3+=1;
		}
		cout<<"��"<<i+1<<"������:"<<setw(5)<<"Y_1:"<<count1<<setw(5)<<"Y_3:"<<count3<< endl;
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
