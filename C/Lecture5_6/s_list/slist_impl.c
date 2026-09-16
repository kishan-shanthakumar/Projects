#include<stdio.h>
#include<stdlib.h>
#include"slist.h"

void initialize_list(s_list* l)
{
	l -> head = NULL;
}

node_t* create_Node(int data)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> data = data;
	new -> link = NULL;
	return new;
}

void insert_beginning(s_list* l, int data)
{
	node_t* new = create_Node(data);
	/*if(l -> head == NULL)
	{
		l -> head = new;
	}
	else*/
	{
		new -> link = l -> head;
		l -> head = new;
	}
}

void insert_rear(s_list* l, int data)
{
	node_t* new = create_Node(data);
	if(l -> head == NULL)
	{
		l -> head = new;
	}
	else
	{
		node_t* temp = l -> head;
		while(temp -> link != NULL)
		{
			temp = temp -> link;
		}
		temp -> link = new;
	}
}

int sum_Of_Elements(s_list* l)
{
	int sum = 0;
	node_t* temp = l -> head;
	while(temp != NULL)
	{
		sum += temp -> data;
		temp = temp -> link;
	}
	return sum;
}

void display_list(s_list* l)
{
	node_t* temp = l -> head;
	while(temp != NULL)
	{
		printf("%d\n", temp -> data);
		temp = temp -> link;
	}
}











