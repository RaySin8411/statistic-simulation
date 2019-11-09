#include<iostream>
#include<iomanip>
#include<cmath>

using namespace std;
double f(double x) {
	double x2 = pow(x,4), x3 =pow(x,7);
	return (3.*x3 - 2.*x2+5.*x -5);
}

int HasRoot(double low, double up, double (*fx)(double)){
	return (fx(low) * fx(up) <= 0.0);
}

int main(int argc, char** argv){
	cout.precision(7);
	double a,b,c,e,fa,fb,fc;
	
	a=0;  		//x0
	b=1;  		//x1
	e=0.00001; 	//accuracy
	cout<<"f(x)=3x^7-2x^4+5x-5"<<endl;
	cout<<"f(a)="<<f(a)<<endl;
	cout<<"f(b)="<<f(b)<<endl<<endl;
	
	if (!(HasRoot(a,b,f)))
	cout << "You have not assumed right a and b\n";
	
	else
	{
		while(abs(a-b)>=e)
		{
			c=(a+b)/2.0;
			fc=f(c);
        	cout<<"a="<<setw(9)<<a<<"  b="<<setw(9)<<b<<"  c="<<setw(9)<<c
			<<"  fc="<<setw(9)<<fc<<endl;
			if(fc==0)	//If fc==0,c is a root of the equation.
			{
				cout<<"The root of the equation is "<<c;
				break;
			}
			if (!(HasRoot(a,c,f)))
			{
				a=c;
			}
			else if (HasRoot(a,c,f))
			{
				b=c;
			}
			
		}
	}
	
	
	cout<<"The root of the equation is "<<c; 
	return 0;
}


