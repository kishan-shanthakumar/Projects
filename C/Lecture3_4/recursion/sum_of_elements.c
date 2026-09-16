#include<stdio.h>
/*int sum_Of_Elements(int* a, int n)
{
	int sum = 0;
	for(int i = 0; i < n; ++i)
	{
		sum += a[i];	
	}
	return sum;
}*/


int sum_Of_Elements(int* a, int n)
{
	if(n == 1)
	{
		return *a;
	}
	else
	{
		//return a[0] + sum_Of_Elements(a + 1, n - 1);
		return a[n - 1] + sum_Of_Elements(a ,n - 1);
	}
}

int main()
{
	int a[5] = {10,20,30,40,50};
	printf("%d\n",sum_Of_Elements(a, 5));
	return 0;
}
