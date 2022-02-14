#include<stdio.h>
#include<stdlib.h>
#include"array.h"

int main()
{
	array_list list;
	list.rear = -1;
	while(1)
	{
		int choice;
		int data;
		printf("Enter your choice\n");
		scanf("%d", &choice);
		switch(choice)
		{
			case 1: printf("Enter the element\n");
				scanf("%d", &data);
				insert(&list, data);
				break;

			case 2: display(&list);
				break;

			default: exit(0);
		
		}
	}
}
