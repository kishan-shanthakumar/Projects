/*#include<stdio.h>
int main()
{
	int a = 10;
	int *p;
	p = &a;
	printf("%d\n", p);
	printf("%d\n", a);
	printf("%d\n", *p);
	
}*/

#include<stdio.h>
int main()
{
	//int a = 10;
	int *p = (int*)malloc(sizeof(int));
	*p = 20;
	int *q = p;
	printf("%d\n", *p);
	free(p);
	p = NULL;
	printf("%d\n", *p);
	
	
}
