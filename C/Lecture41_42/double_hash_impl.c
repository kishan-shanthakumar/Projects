#include<stdio.h>
#include<stdlib.h>
#include"double_hash.h"

void initialize_Hash(hash_t* hashtable, int tablesize)
{
	for(int i = 0; i < tablesize; ++i)
	{
		hashtable[i].flag = 0;
	}
}


int hash2(int key)
{
	return PRIME_NO - (key % PRIME_NO);
}

void insert_Into_Hash(hash_t* hashtable, int tablesize, int key, int* no_Of_Elements)
{
	int index = key % tablesize;
	int x = index;
	
	int h = hash2(key);
	if(*no_Of_Elements == tablesize)
	{
		printf("Table is full\n");
		//return;
	}
	else
	{
		for(int i = 1; i < tablesize; ++i)
		{
			if(hashtable[index].flag == 0)
			{
				hashtable[index].key = key;	
				hashtable[index].flag = 1;
				(*no_Of_Elements)++;
				return;	
			}
			
			index = (x + i * h) % tablesize;
		}
	}
}

void display(hash_t* hashtable, int tablesize)
{
	for(int i = 0; i < tablesize; ++i)
	{
		printf("%d :", i);
		if(hashtable[i].flag != 0)
		{
			printf("%d", hashtable[i].key);
		}
		printf("\n");
	}
}

void delete_From_Hash(hash_t* hashtable, int tablesize, int key, int* no_Of_Elements)
{
	int index = key % tablesize;
	int x = index;
	int h = hash2(key);
	for(int i = 1; i < tablesize; ++i)
	{
		if(hashtable[index].flag == 1 && hashtable[index].key == key)
		{
			hashtable[index].flag = 0;
			(*no_Of_Elements)--;
			return;	
		}
		index = (x + i * h) % tablesize;
	}
	printf("Key not found\n");
}















