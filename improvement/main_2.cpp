#include <iostream>
#include <math.h> 
#include <iomanip>
#include "Uniform_0_1.h" 
using namespace std;
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char** argv) {
	cout<<"HW2_Q5"<<endl;
	cout<<"-----------------"<<endl;
	int i,j,k,s,l;
	double lam=2;
	double ho;
	double x,y=1,fx,sum=0,sum1=0;
	double obs,uni,p;
	const int max_l	= 2000;  //	試驗的次數 
	int n;
	int r[5]={100,500,1000,10000,50000};
	double mean,var;
	Rstart(1,2,3,4);
	cout<<" CLT Test "<<endl;
	cout<<" n "<<setw(7)<<" p "<<endl;
for(s=0;s<5;s++)
{
	n=r[s];
	sum1=0;
	int m[n];
	for(l=0;l<max_l;l++){
		
		for(k=0;k<n;k++)
		{
			uni=Uni();
			sum=0;
	 		for(i=0;i<40;i++)
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
    for(i=0;i<n;i++)
    {	
    	sum+=m[i];
	}
	mean=sum/n;
	//樣本變異數 
	sum=0;
	for(i=0;i<n;i++)
	{
		sum+=pow(m[i]-mean,2);
	}
	var=sum/n;	
	p=double(mean*n-n*lam)/sqrt(n*lam);
	if(p>0)
	{
		sum1=sum1+1;
	}
	}
	ho=double(sum1)/double(max_l);
	cout<<setw(10)<<n<<setw(10)<<ho<<endl;
 
}
	return 0;
}
