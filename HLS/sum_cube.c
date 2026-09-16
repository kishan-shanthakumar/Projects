#include<math.h>

typedef struct{
long num1;
long num2;
}arr;

long absolute_value(long a)
{
	if(a < 0)
	{
		return -1 * a;
	}
	else
		return a;
}

void fac(long a_g, long* j_g, long* k_g)
{
	int i;
	long j,c=0,g=0,z=0;
	long y = a_g;
	if(a_g < 0)
	{
		y = -1 * y;
	}
	float x=sqrt(y);
	arr answ[100];
	if (a_g % 2==0)
		z=1;
	else
		z=2;
	for(i=1;i<=x;i+=z)
	{
		if(absolute_value(a_g)%i==0)
		{
			answ[c].num1=i;
			answ[c].num2=a_g/i;
			c++;
		}
	}
	int flag=0;
	for(i=0;i<c;i++)
	{
		arr temp=answ[i];
		for(j=0;j<temp.num1+1;j++)
		{
			if( absolute_value((j*j)-(j*(temp.num1-j))+((temp.num1-j)*(temp.num1-j))) == temp.num2)
			{
				*j_g=j;
				*k_g=temp.num1-j;
				flag=1;
				break;
			}
		}
		if(flag==1)
			break;
	}
	if(flag==0)
	{
		*j_g=0;
		*k_g=0;
	}
}

void sumcube(int a, long* outp1, long* outp2)
{
	long temp1,temp2,temp3;
	long temp11,temp21,temp31;
	long temp12,temp22,temp32;
	long i,j ;
	int flag = 0;
		for(i=0;i<1000;i++)
		{
			#pragma HLS UNROLL
			temp1 = a + i*i*i;
			temp2 = a - i*i*i;
			temp3 = i*i*i - a;
			fac(temp1, &temp11, &temp12);
			fac(temp2, &temp21, &temp22);
			fac(temp3, &temp31, &temp32);
			if(temp11 != 0 && temp12 != 0)
			{
				*outp1 = temp11;
				*outp2 = temp12;
				flag = 1;
			}
			if(temp21 != 0 && temp32 != 0)
			{
				*outp1 = temp21;
				*outp2 = temp22;
				flag = 1;
			}
			if(temp31 != 0 && temp32 != 0)
			{
				*outp1 = temp31;
				*outp2 = temp32;
				flag = 1;
			}
			if(flag == 1)
				break;
		}
}
