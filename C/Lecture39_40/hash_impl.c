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


void insert(hash_t* hashtable, int key, char* name, int tablesize)
{
	
	int index = key % tablesize;
	int x = index;
	for(int i = 1; i < tablesize; ++i)
	{
		if(hashtable[index].flag != 0)
		{
			index = (x + i * i) % tablesize;
		}
		else
		{
			hashtable[index].key = key;
			strcpy(hashtable[index].name, name);
			hashtable[index].flag = 1;
			return;
		}
		
	}
	
}


/*void insert(hash_t* hashtable, int key, char* name, int tablesize, int* no_Of_Elements)
{
	int index = key % tablesize;
	int i = 0;
	int x = index;
	if(tablesize == *no_Of_Elements)
	{
		printf("Hash table is full, cannot insert\n");

	}
	else
	{
		while(hashtable[index].flag != 0)
		{
			index = (x + i * i) % tablesize;
			++i;
		}
		hashtable[index].key = key;
		strcpy(hashtable[index].name, name);
		hashtable[index].flag = 1;
		(*no_Of_Elements)++;
	}
	
}*/

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


void delete_From_Hash(hash_t* hashtable, int key, int tablesize)
{
	int index = key % tablesize;
	int i;
	int x = index;
	for(i = 0; i < tablesize; ++i)
	{
		if(hashtable[index].flag == 1 && hashtable[index].key == key)
		{
			hashtable[index].flag = 0;
			break;
		}
		index = (x + i * i) % tablesize;
	}
	if(i == tablesize)
	{
		printf("Key not found\n");
	}
	
}
	



























