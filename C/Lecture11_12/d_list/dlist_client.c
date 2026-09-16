#include<stdio.h>
#include<stdlib.h>
#include"dlist.h"

int main()
{
	d_list list;
	initialize_list(&list);
	while(1)
	{
		printf("1. insert beginning\n");
		printf("2. display list\n");
		printf("3. insert rear\n");
		printf("4. delete beginning\n");
		printf("5. delete rear\n");
		printf("6. Insert at index\n");
		int choice;
		int data;
		int index;
		printf("Enter your choice\n");
		scanf("%d", &choice);
		switch(choice)
		{
			case 1: printf("Enter the element\n");
				scanf("%d", &data);
				insert_beginning(&list, data);
				break;

			case 2: display_list(&list);
				break;

			case 3: printf("Enter the element\n");
				scanf("%d", &data);
				insert_rear(&list, data);
				break;

			case 4: delete_beginning(&list);	
				break;

			case 5: delete_rear(&list);	
				break;

			
			case 6: printf("Enter the position and element\n");
					scanf("%d%d",&index, &data);
					insert_At_Index(&list, index, data);
					break;

			default: exit(0);
		
		}
	}
	return 0;
}
