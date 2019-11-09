#include <iostream>
#include <cmath>

using namespace std;
double bisection (int z)
{
	
	
	double r;
	r= 2 * (z)^3 - 11*z - 50;
	
	return (r);
}


int main (int argc, char** argv) 
{
	double fa=0;
	int x=0;
	double fb=0;
	double m=0, product=0;
    double a, b;
	cout << "Please enter your a value " << endl; 
	cin >> a;
	cout << "Please enter your b value " << endl;
	cin >> b;
loop:
	
	fa= bisection (a);
	fb = bisection (b);
	product = fa * fb; 
	m = (a+b)/2;
	if (product < 0) {
		b=m;
	}
	else {
		a= m;
	}
	x= abs (a-b);
	
	if (x > 0.000000001) {
		goto loop; 
	}
	else {
		goto loopa;
	}
	
loopa:
	cout << "The root value is " << m << endl;
    return 0;
}
