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

			case 2: display_list(&list);
				break;

			case 3: printf("Enter the element\n");
				scanf("%d", &data);
				insert_rear(&list, data);
				break;

			//case 3: printf("%d\n",sum_Of_Elements(&list));
				    break;

			case 4: delete_beginning(&list);	
				break;

			//case 5: delete_rear(&list);	
				break;

			//case 6: printf("%d\n",count_Nodes(&list));	
				break;

			case 7: printf("Enter the element to be deleted\n");
				scanf("%d", &data);
				//delete_Element(&list, data);	
				break;

			case 8: printf("Enter the position and element\n");
					scanf("%d%d", &pos, &data);
					//insert_At_Position(&list, pos, data);
					break;

			//case 9: printf("%d\n",find_Largest(&list));
					break;

			
			default: exit(0);
		
		}
	}
	return 0;
}
