#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"hash.h"

void initialize_Hash(hash_t* hashtable, int tablesize)
{
	for(int i = 0; i < tablesize; ++i)
	{
		hashtable[i].flag = 0;
	}
}


void insert(hash_t* hashtable, int key, char* name, int tablesize, int* no_Of_Elements)
{
	
	int index = key % tablesize;
	if(*no_Of_Elements == tablesize)
	{
		printf("Hashtable is full, cannot insert\n");
	}
	else
	{
		while(hashtable[index].flag != 0)
		{
			index = (index + 1) % tablesize;
		}
		hashtable[index].key = key;
		strcpy(hashtable[index].name, name);
		hashtable[index].flag = 1;
	
		(*no_Of_Elements)++;
	}
}


void display(hash_t* hashtable, int tablesize)
{
	for(int i = 0; i < tablesize; ++i)
	{
		printf("%d :", i);
		if(hashtable[i].flag != 0)
		{
			printf("%d %s", hashtable[i].key, hashtable[i].name);
		}
		printf("\n");
	}
}


void delete_From_Hash(hash_t* hashtable, int key, int tablesize, int* no_Of_Elements)
{
	int index = key % tablesize;
	/*int i = 0;
	while(hashtable[index].key != key && i < tablesize)
	{
		index = (index + 1) % tablesize;
		++i;
	}
	if(i == tablesize)
	{
		printf("Key not found\n");
	}
	else
	{
		(*no_Of_Elements)--;
		hashtable[index].flag = 0;
	}*/
	
	int i;
	int count = 0;
	if(hashtable[index].flag == 0)
	{
		printf("Key not found\n");
		return;
	}
	for(index, tablesize; tablesize != 0 && hashtable[index].key != key ; tablesize--, index = (index + 1) % tablesize)
	{
		
	}
	if(tablesize == 0)
	{
		printf("Key not found\n");
	}
	else
	{
		(*no_Of_Elements)--;
		hashtable[index].flag = 0;
	}
}
	



























