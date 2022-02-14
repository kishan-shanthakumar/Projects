#include<stdio.h>
#include<stdlib.h>
#include"slist.h"

int main()
{
	s_list list;
	s_list list2;
	initialize_list(&list);
	while(1)
	{
		int choice;
		int data;
		int pos;
		printf("Enter your choice\n");
		scanf("%d", &choice);
		switch(choice)
		{
			case 1: printf("Enter the element\n");
				scanf("%d", &data);
				insert_beginning(&list, data);
				break;

			case 2: printf("Enter the element\n");
				scanf("%d", &data);
				insert_rear(&list, data);
				break;

			case 3: delete_beginning(&list);	
				break;

			case 4: delete_rear(&list);	
				break;

			case 5: display_list(&list);
				break;

			default: exit(0);
		
		}
	}
	return 0;
}
