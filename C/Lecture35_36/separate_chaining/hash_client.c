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
		}
	}
}
