#include <iostream>
#include <math.h> 
#include <iomanip>
#include "Uniform_0_1.h" 
using namespace std;
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char** argv) {
	cout<<"HW2_Q5"<<endl;
	cout<<"-----------------"<<endl;
	int i,j,k,s;
	double lam=2;
	double x,y=1,fx,sum=0,sum1=0;
	double obs,uni,p;
	int m[10000];
	int n=10000;
	int r[5]={100,500,1000,10000,50000};
	double mean,var;
	Rstart(1,2,3,4);
	cout<<" CLT Test "<<endl;
	cout<<" n "<<setw(9)<<" p "<<endl;
for(s=0;s<5;s++)
{
		n=r[s];
		sum1=0;
	
	for(k=0;k<10000;k++)
	{
	uni=Uni();
	sum=0;
	 for(i=0;i<13;i++)
	 {
		for(j=1;j<=i;j++)
		{
			y*=j;
		}
		fx=(exp(-lam)*pow(lam,i))/y;
		sum+=fx;
		y=1; //y return

		if(sum>=uni)
		{
			m[k]=i;
			break;
		}
	  }
	
    }
    //平均數 
    sum=0;
    for(i=0;i<10000;i++)
    {
    	sum+=m[i];
	}
	mean=sum/10000;
	//樣本變異數 
	sum=0;
	for(i=0;i<10000;i++)
	{
		sum+=pow(m[i]-mean,2);
	}
	var=sum/10000;
	
	p=double(sum-n*lam)/sqrt(n*lam);
	if(p>0)
	{
		sum1=sum1+1;
	}
	
	cout<<n<<setw(10)<<p<<endl; 
	
 
}
	return 0;
}
