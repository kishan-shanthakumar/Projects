#include<stdio.h>
#include"bst_array.h"

void insert(int* array, int item)
{
	int i = 0;
	while(array[i] != 0)
	{
		if(array[i] > item)
		{
			i = 2 * i + 1;
		}
		else
		{
			i = 2 * i + 2;
		}
	}
	array[i] = item;
}


void inorder(int* array, int i)
{
	if(array[i] != 0)
	{
		inorder(array, 2 * i + 1);
		printf("%d\n", array[i]);
		inorder(array, 2 * i + 2);
	}
}


void preorder(int* array, int i)
{
	if(array[i] != 0)
	{
		printf("%d\n", array[i]);
		preorder(array, 2 * i + 1);
		preorder(array, 2 * i + 2);
	}
}


void postorder(int* array, int i)
{
	if(array[i] != 0)
	{
		postorder(array, 2 * i + 1);
		postorder(array, 2 * i + 2);
		printf("%d\n", array[i]);
	}
}


