#include<stdio.h>
#include<stdlib.h>
#include"bst_array.h"
int main()
{
	int array[100] = {0};
	int ch;
	int item;
	while(1)
	{
		printf("Enter your choice\n");
		scanf("%d", &ch);
		switch(ch)
		{
			case 1: printf("Enter the element to be inserted\n");
				scanf("%d", &item);
				insert(array, item);	
				break;

			case 2: inorder(array, 0);
					break;

			case 3: preorder(array, 0);
					break;

			case 4: postorder(array, 0);
					break;
		
			default: exit(0);
		}
	}
}
