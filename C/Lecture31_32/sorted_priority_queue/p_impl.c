#include<stdio.h>
#include<stdlib.h>
#include"p.h"

void initialize_List(list_t* l)
{
	l -> head = NULL;
}

node_t* create_Node(int data, int priority)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> data = data;
	new -> priority = priority;
	new -> link = NULL;

	return new;
}

void enqueue(list_t* l, int data, int priority)
{
	node_t* new = create_Node(data, priority);
	if(l -> head == NULL)
	{
		l -> head = new;
	}
	else
	{
		node_t* curr = l -> head;
		node_t* prev = NULL;
		while(curr != NULL && curr -> priority > new -> priority)
		{
			prev = curr;
			curr = curr -> link;
		}
		if(prev == NULL)
		{
			new -> link = curr;
			l -> head = new;
		}
		else
		{
			new -> link = curr;
			prev -> link = new;
		}
	}
}

void dequeue(list_t* l)
{
	if(l -> head == NULL)
	{
		return;
	}
	else if(l -> head -> link == NULL)
	{
		free(l -> head);
		l -> head = NULL;
	}
	else
	{
		node_t* curr = l -> head;
		l -> head = l -> head -> link;
		free(curr);
		curr = NULL;
	}

}

void display(list_t* l)
{
	if(l -> head == NULL)
	{
		printf("Empty list\n");	
		return;
	}
	node_t* temp = l -> head;
	while(temp != NULL)
	{
		printf("%d %d ", temp -> data, temp -> priority);
		temp = temp -> link;
	}
	printf("\n");
}




