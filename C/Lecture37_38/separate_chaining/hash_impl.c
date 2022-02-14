#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"hash.h"

void initialize_Hash(hash_t* hashtable, int tablesize)
{
	for(int i = 0; i < tablesize; ++i)
	{
		hashtable[i].head = NULL;
	}
}

node_t* create_Node(int key, char* name)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> key = key;
	strcpy(new -> name, name);
	new -> link = NULL;
	
	return new;
}

void insert(hash_t* hashtable, int key, char* name, int tablesize)
{
	node_t* new = create_Node(key, name);
	
	int index = key % tablesize;

	new -> link = hashtable[index].head;
	hashtable[index].head = new;
}


void display(hash_t* hashtable, int tablesize)
{
	for(int i = 0; i < tablesize; ++i)
	{
		node_t* temp = hashtable[i].head;
		printf("%d :", i);
		while(temp != NULL)
		{
			printf("%d ", temp -> key);
			printf("%s", temp -> name);
			printf(" -> ");
			temp = temp -> link;
		}
		printf("\n");
	}
}


void delete_From_Hash(hash_t* hashtable, int key, int tablesize)
{
	int index = key % tablesize;
	node_t* temp = hashtable[index].head;
	node_t* prev = NULL;
	while(temp != NULL && temp -> key != key)
	{
		prev = temp;
		temp = temp -> link;
	}
	if(temp == NULL)
	{
		printf("key not found\n");
	}
	else
	{
		if(prev == NULL)
		{
			hashtable[index].head = temp -> link;
			free(temp);
		}
		else
		{	
			prev -> link = temp -> link;
			free(temp);
		}
	}
} 

void search_Hash(hash_t* hashtable, int key, int tablesize)
{
	int index = key % tablesize;
	node_t* temp = hashtable[index].head;
	//node_t* prev = NULL;
	while(temp != NULL && temp -> key != key)
	{
		//prev = temp;
		temp = temp -> link;
	}
	if(temp == NULL)
	{
		printf("key not found\n");
	}
	else
	{
		printf("key found\n");
		printf("%d %s\n", temp -> key, temp -> name);
	}
}


























