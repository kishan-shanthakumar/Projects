#include<stdio.h>
#include<stdlib.h>
#include"hash.h"

int main()
{
	int key;
	int choice;
	char a[50];
	int tablesize;
	printf("Enter the tablesize\n");
	scanf("%d", &tablesize);
	hash_t* hashtable = (hash_t*)malloc(sizeof(hash_t) * tablesize);
	
	initialize_Hash(hashtable, tablesize);
	while(1)
	{
		printf("1: insert\n");
		printf("2: display\n");
		printf("3: delete\n");
		printf("4: search\n");
		printf("Enter your choice\n");
		scanf("%d", &choice);
		switch(choice)
		{
			case 1: printf("Enter the key and name\n");
					scanf("%d%s", &key, a);
					insert(hashtable, key, a, tablesize);
					break;

			case 2: display(hashtable, tablesize);
					break;

			case 3: printf("Enter the key to be deleted\n");
					scanf("%d", &key);
					delete_From_Hash(hashtable, key, tablesize);
					break;

			case 4: printf("Enter the key to be deleted\n");
					scanf("%d", &key);
					search_Hash(hashtable, key, tablesize);
					break;
			
		}
	}
}
