
#include<stdio.h>


int main()
{
	int n;
	printf("Enter the number of nodes\n");
	scanf("%d", &n);
	int a[7];
	for(int i = 0; i <= n; ++i)
	{
		scanf("%d", a[i]);
	}
	tree_t t;
	initialize_Tree(&t);
	for(int i = 0; i <= n; ++i)
	{
		insert(&t, a[i]);
	}
}
