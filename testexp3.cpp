#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include<iostream>

double ran_expo(double lambda){
    double u;
    u = rand() / (RAND_MAX + 1.0);
    return -log(1- u) / lambda;
}

int main(int argc,char** argv)
{
	
    int i;
    srand((unsigned)time(NULL));
    for (i=0; i<5; i++)
        printf("%f\n", ran_expo(5));
    return 0;
}

