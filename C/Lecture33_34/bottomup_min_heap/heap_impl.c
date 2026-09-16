#include<stdio.h>
#include"heap.h"

void read_Array(int* array, int n)
{
	for(int i = 1; i <= n; ++i)
	{
		scanf("%d", &array[i]);
	}
}

void display_Array(int* array, int n)
{
	for(int i = 1; i <= n; ++i)
	{
		printf("%d ", array[i]);
	}
}

void swap(int* i, int* j)
{
	int temp = *i;
	*i = *j;
	*j = temp;
}


void heapify(int* array, int n, int position)
{
	int i,j;
	i = position;
	j = 2 * i;
	int flag = 0;
	while(j <= n && !flag)
	{
		if(j < n && array[j + 1] < array[j])
		{
			++j;
		}
		if(array[i] > array[j])
		{
			swap(&array[i], &array[j]);
			i = j;
			j = 2 * i;
		}
		else
		{
			flag = 1;
		}
	}
}

void sort(int* array, int n)
{
	for(int i = n/2; i >= 1; --i)
	{
		heapify(array, n, i);	
	}
	display_Array(array, n);
	for(int i = n; i > 1; --i)
	{
		swap(&array[1], &array[i]);
		heapify(array, i - 1, 1);
	}
	display_Array(array, n);
	
}

