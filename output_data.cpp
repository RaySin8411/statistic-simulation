#include<iostream>
#include<iomanip>
#include <stdlib.h>
#include <fstream>

using namespace std;

int main(int argc,char** argv){
	int i,j;

	ofstream outfile("data1.txt");
	if(!outfile)
    {
     cout << "No enough space for the file out.txt!" << endl;
    return(0);
 	}
	for(i=1;i<10;i++)
	{
	for(j=1;j<10;j++)
	{
	  outfile<<j << 'x' << i << "= "<<setw(2)<< i*j << " " ;
	}
	
	outfile<<endl;
	} 
	outfile.close();
	system("type data1.txt");
	cout<<endl;
	return 0;
}
