
#include<stdio.h>
#include"tree.h"

int main()
{
	int n, ele;
	//printf("Enter the number of nodes\n");
	//scanf("%d", &n);
	//int a[7];
	/*for(int i = 0; i <= n; ++i)
	{
		scanf("%d", a[i]);
	}*/
	int a[] = {20,50,40,30,60,70};

	tree_t t;
	initialize_Tree(&t);
	for(int i = 0; i < 6; ++i)
	{
		insert(&t, a[i]);
	}
	inorder(&t);
	printf("\n");
	preorder(&t);
	printf("\n");
	postorder(&t);
	printf("\n");
	printf("Min element %d\n", min(&t));
	printf("Enter the element to be searched\n");
	scanf("%d", &ele);
	if(search(&t, ele))
	{
		printf("Element found\n");
	}
	else
	{
		printf("Element not found\n");
	}
}
