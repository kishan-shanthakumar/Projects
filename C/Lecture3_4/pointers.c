/*#include<stdio.h>

int main()
{
	int *p = (int*)malloc(sizeof(int));
	*p = 20;
	free(p);
	p = NULL;
	printf("%d\n", *p);
	return 0;
}

#include<stdio.h>

int main()
{
	int a = 10;
	int *p = &a;
	int b = 100;
	p = &b;
	return 0;
}*/

/*int main()
{
	int *p = (int*)malloc(3 * sizeof(int));
	*p = 20;
	*(p+1) = 30;
	*(p +2) = 40;
	int *q;
	free(p+1);
	printf("%d\n", *(p-1));
	return 0;
}*/



int* foo(int* x)
{
	return x;
}
int foo_1(int* x)
{
	return *x;
}
int *foo_2(int* x)
{
	return &x;
}

int main()
{
	int a = 10;
	int b = *foo(&a);
	printf("%d\n", b);
	b = foo_1(&a);
	printf("%d\n", b);
	b = *foo_2(&a);
	printf("%d\n", b);
	return 0;
}


