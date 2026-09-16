#include<stdio.h>
#include<stdlib.h>
#include"priority.h"

int main()
{
	int ch;
	int num;
	printf("Enter the number of elements\n");
	scanf("%d", &num);
	heap_t* queue = (heap_t*)malloc(sizeof(heap_t) * num);
	heap_t ele;
	int n = 0;
	while(1)
	{	
		printf("1. Insert\n");
		printf("2. Delete minimum\n");	
		printf("3. Display\n");
		printf("Enter your choice\n");
		scanf("%d", &ch);
		switch(ch)
		{
			case 1: printf("Enter the data and priority\n");	
				scanf("%d%d", &ele.data, &ele.priority);
				insert(queue, ele, &n);
				break;

			case 2: delete_Min(queue, &n);
				break;

			case 3: display(queue, n);
				break;
		}
	}
}
