#include <iostream>
#include <math.h> 
#include "Uniform_0_1.h" 
/* run this program using the console pauser or add your own getch, system("pause") or input loop */
using namespace std;
int main(int argc, char** argv) {
	cout<<"HW2_Q4"<<endl;
	cout<<"------------"<<endl;
	int i,j,k;
	double lam=2;
	double x,y=1,fx,sum=0;
	double mean,var;
	int m[10000];
	double uni; //�����ܼ����L�h�P�_ 
	Rstart(1,2,3,8);//�ؤl 
	for(k=0;k<10000;k++){
	
	uni= Uni();
	sum = 0 ;
	for(i=0;i<13;i++)
	{
		for(j=1;j<=i;j++)
		{
			y*=j;
		}
		fx=(exp(-lam)*pow(lam,i))/y;
		sum+=fx;
		y=1; //y return
		//cout<<"fx="<<fx<< "       ";
		//cout<<"Fx="<<sum<<endl;
		
		//�P�_�� 
		if (sum>=uni)  
	  	{	
		m[k]=i; //�o�̦���L 
		break;
	  }	 	
	}
}
//�⥭���� 
	sum = 0;
	for(i=0; i<10000;i++){
		sum +=m[i] ;
	} 
	mean = sum/10000;
//���ܲ��� 
	sum= 0;
	for(i=0; i<10000;i++){
		sum +=pow(m[i]-mean,2) ;
	} 
	var = sum / 10000;
	
	cout<<"mean:"<<"    "<<mean<<endl;
	cout<<"var:"<<"    "<<var<<endl;
	return 0;
}
