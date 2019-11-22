double uni_u[97],e_c,e_cd,e_cm;//for Uni()
int e_i,e_j;  //for Uni()

void Rstart(int i,int j,int k,int L)
{
	int ii,jj,m;
	double s,t;
    for(ii=0;ii<97;ii++)
    {
    	s=0;t=0.5;
        for(jj=0;jj<24;jj++)
        {
        	m=(((i*j)%179)*k)%179;
            i=j;
            j=k;
            k=m;
            L=(53*L+1)%169;
            if((L*m)%64>=32)
            	s+=t;
            t*=0.5;
        }
        uni_u[ii]=s;
    }
    e_c=362436.0/16777216.0;
    e_cd=7654321.0/16777216.0;
    e_cm=16777213.0/16777216.0;
    e_i=96;
    e_j=32;
}

double Uni()
{
	double uni=uni_u[e_i]-uni_u[e_j];
    if(uni<0)
    	uni+=1;
    uni_u[e_i]=uni;
    e_i--;
    if(e_i==-1)
    	e_i=96;
    e_j--;
    if(e_j==-1)
    	e_j=96;
    e_c-=e_cd;
    if(e_c<0)
    	e_c+=e_cm;
    uni-=e_c;
    if(uni<0)
    	uni+=1;
    return uni;
}
