#include<stdio.h>
#include<stdlib.h>
#include"double_hash.h"

int main()
{
	int ch;
	int key;
	int tablesize;
	int no_Of_Elements = 0;
	printf("1.insert\n");
	printf("2.delete\n");
	printf("3.display\n");

	printf("Enter the tablesize\n");
	scanf("%d", &tablesize);

	hash_t* hashtable = (hash_t*)malloc(sizeof(hash_t) * tablesize);
	initialize_Hash(hashtable, tablesize);

	while(1)
	{
		printf("Enter your choice\n");
		scanf("%d", &ch);
		switch(ch)
		{
			case 1: printf("Enter the key\n");
					scanf("%d", &key);
					insert_Into_Hash(hashtable, tablesize, key, &no_Of_Elements);
					break;

			case 2: printf("Enter the key\n");
					scanf("%d", &key);
					delete_From_Hash(hashtable, tablesize, key, &no_Of_Elements);
					break;

			case 3: display(hashtable, tablesize);
					break;
		}
	}

}
