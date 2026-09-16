#include<stdio.h>
#include<stdlib.h>
#include"p.h"

int main()
{
	list_t l;
	initialize_List(&l);
	int data;
	int priority;
	int ch;
	while(1)
	{
		printf("Enter your choice\n");
		scanf("%d", &ch);
		switch(ch)
		{
			case 1: printf("Enter the data and priority\n");
				scanf("%d%d", &data, &priority);
				enqueue(&l, data, priority);
				break;

			case 2: dequeue(&l);	
				break;

			case 3: display(&l);
				break;
			
			default: exit(0);
		}
	}
	
}
