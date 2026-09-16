#include<stdio.h>
#include"priority.h"

void delete_Min(heap_t* heap, int* n)
{
	heap[0] = heap[*n - 1];
	(*n)--;
	heapify(heap, *n);
}

void swap(heap_t* i, heap_t* j)
{
	heap_t temp = *i;
	*i = *j;
	*j = temp;
}

void heapify(heap_t* heap, int n)
{
	int i;
	int j;
	i = 0;
	j = 2 * i + 1;
	int flag = 0;

	while(j <= n && !flag)
	{
		if((j + 1) < n && heap[j + 1]. priority < heap[j]. priority)
		{
			++j;
		}
		if(heap[i].priority > heap[j].priority)
		{
			swap(&heap[i], &heap[j]);
			i = j;
			j = 2 * i + 1;
		}
		else
		{
			flag = 1;
		}
	}
} 

void insert(heap_t* heap, heap_t ele, int* n)
{
	int i, j;
	i = *n;
	heap[i] = ele;
	(*n)++;
	j = (i - 1) / 2; //find parent and store in j

	while((i > 0) && heap[j].priority > heap[i].priority)
	{
		swap(&heap[i], &heap[j]);
		i = j;
		j = (i - 1)/2; //update parent
	}
}

void display(heap_t* heap, int n)
{
	for(int i = 0; i < n; ++i)
	{
		printf("%d %d ", heap[i].data, heap[i].priority);
	}
	printf("\n");
}
