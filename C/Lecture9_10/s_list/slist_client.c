#include<stdio.h>
#include<stdlib.h>
#include"slist.h"

int main()
{
	s_list list;
	s_list list2;
	initialize_list(&list, &list2);
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

			case 3: printf("%d\n",sum_Of_Elements(&list));
				    break;

			case 4: delete_beginning(&list);	
				break;

			case 5: delete_rear(&list);	
				break;

			case 6: printf("%d\n",count_Nodes(&list));	
				break;

			case 7: printf("Enter the element to be deleted\n");
				scanf("%d", &data);
				delete_Element(&list, data);	
				break;

			case 8: printf("Enter the position and element\n");
					scanf("%d%d", &pos, &data);
					insert_At_Position(&list, pos, data);
					break;

			case 9: printf("%d\n",find_Largest(&list));
					break;

			case 11: reverse_List(&list);
				 break;

			case 12:printf("Enter the element\n");
				scanf("%d", &data);
				ordered_List(&list, data);
				break;

			case 13: printf("Enter the element\n");
				scanf("%d", &data);
				insert_beginning(&list2, data);
				break;

			case 14: display_list(&list2);
				break;

			case 15: display_list(&list);
				break;

			case 16: concatenate_List(&list, &list2);
				 break;

			case 17: delete_List(&list);
				 break;

			

			
			default: exit(0);
		
		}
	}
	return 0;
}
