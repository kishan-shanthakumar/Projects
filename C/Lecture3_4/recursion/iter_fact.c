#include<stdio.h>
/*int fact(int n)
{
	int fact = 1;
	for(int i = 1; i<=n; ++i)
	{
		fact = fact * i;
	}
	return fact;
}*/

int fact(int n, int v)
{
	if(n == 0)
	{
		return v;
	}
	else
	{
		return fact(n - 1, n * v);
	}
}
int main()
{

	printf("%d\n",fact(1000, 1));
	return 0;	
}
