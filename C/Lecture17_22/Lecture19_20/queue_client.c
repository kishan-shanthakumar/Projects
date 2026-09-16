#include"queue.h"
#include<stdio.h>
#include<stdlib.h>


int main()
{
	Q q;
	initialize_Queue(&q);
	
	while(1)
	{
		int data;
		int ch;
		printf("Enter your choice\n");
		scanf("%d", &ch);
		switch(ch)
		{
			case 1: printf("Enter the element to be enqueued\n");
				scanf("%d", &data);
				enqueue(&q, data);
				break;

			case 2: printf("%d\n", dequeue(&q));
				break;

			case 3: display(&q);
				break;

			case 4: printf("%d\n", front(&q));
				break;
			
			default: exit(0);
			
		}
	}
	return 0;
}
