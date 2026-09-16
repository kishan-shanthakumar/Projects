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
		new -> link = l -> head;
		l -> head = new;	
	}
	
}

void dequeue(list_t* l)
{
	if(l -> head == NULL)
	{
		return;
	}
	
	/*node_t* curr = l -> head;
	node_t* prev = NULL;
	int max = curr -> priority;
	node_t* x = curr;
	node_t* x_prev = NULL;
	while(curr != NULL)
	{
		if(curr -> priority > max)
		{	
			max = curr -> priority;
			x_prev = prev;
			x = curr;
		}
		prev = curr;
		curr = curr -> link;
	}
	if(prev == NULL)
	{
		l -> head = l -> head -> link;
		printf("Element deleted is %d %d\n", curr -> data, curr -> priority);
		free(curr);
	}
	else
	{
		x_prev -> link = x -> link;
		printf("Element deleted is %d %d\n", x -> data, x -> priority);
		free(x);
	}*/
	curr = l -> head;
	if(max == curr -> priority)
	{
		printf("Element deleted is %d %d\n", curr -> data, curr -> priority);
		l -> head = curr -> link;
		free(curr);
	}
	else
	{
		while(curr -> link != NULL && curr -> link -> priority != max)
		{
			curr = curr -> link;
		}
		node_t* next = curr -> link;
		printf("Element deleted is %d %d\n", next -> data, next -> priority);
		curr -> link = curr -> link -> link;
		free(next);
		next = NULL;
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




