#include <iostream>
#include <stdlib.h>// for system
#include <stdio.h>// for printf
using namespace std;

 int main(int argc, char** argv) {
 FILE *fp;//file pointer
 int var,i;
 int sum = 0;
 double average;

 fp = fopen("data1.txt","w"); /* open file pointer */

 for ( i = 0; i < 5; i++ )
 {
 printf("Input the %dth whole number here ==> ",i+1);
 scanf("%d",&var);
 sum += var;
 fprintf(fp,"%d\n",var);
 }

 average = double(sum) / 5.0;
 fprintf(fp,"The average of these whole number is %6.2f\n",average);
 fclose(fp);

 system("type data1.txt");//Showing the content of data1.txt on the screen.
 return 0;
 }
