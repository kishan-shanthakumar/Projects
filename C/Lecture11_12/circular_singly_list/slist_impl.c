#include<stdio.h>
#include<stdlib.h>
#include"slist.h"

void initialize_list(s_list* l)
{
	l -> head = NULL;
	l -> no_Of_Nodes = 0;
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
	if(l -> head == NULL)
	{
		new -> link = new;
	}
	else
	{
		node_t* temp = l -> head;
		while(temp -> link != l -> head)
		{
			temp = temp -> link;
		}
		temp -> link = new;
		new -> link = l -> head;	
	}
	l -> head = new;
	++l -> no_Of_Nodes;
}

void insert_rear(s_list* l, int data)
{
	node_t* new = create_Node(data);
	if(l -> head == NULL)
	{
		l -> head = new;
		new -> link = new;
	}
	else
	{
		node_t* temp = l -> head;
		while(temp -> link != l -> head)
		{
			temp = temp -> link;
		}
		temp -> link = new;
		new -> link = l -> head;
	}
	++l -> no_Of_Nodes;
}


void delete_beginning(s_list* l)
{
	if(l -> head == NULL)
	{
		printf("Empty list\n");
		return;
	}
	else if(l -> head -> link != l -> head)
	{
		free(l -> head);
		l -> head = NULL;
	}
	else
	{
		node_t* temp = l -> head;
		while(temp -> link != l -> head)
		{
			temp = temp -> link;
		}
		node_t* temp1 = l -> head;
		temp -> link = l -> head -> link;
		l -> head = temp1 -> link;
		free(temp1);
		temp1 = NULL;
	}
	--l -> no_Of_Nodes;
}

void delete_rear(s_list* l)
{
	node_t* temp = l -> head;
	if(l -> head == NULL)
	{
		printf("Empty list\n");
		return;
	}
	else if(temp -> link == l -> head)
	{
		free(temp);
		l -> head = NULL;
	}
	else
	{
		while(temp -> link -> link != l -> head)
		{
			temp = temp -> link;
			
		}
		free(temp -> link);
		temp -> link = l -> head;
	}
	--l -> no_Of_Nodes;
}


void display_list(s_list* l)
{
	if(l -> head == NULL)
	{
		printf("Empty list, cannot display\n");
	}
	else
	{
		node_t* temp = l -> head;
		while(temp -> link != l -> head)
		{
			printf("%d\n", temp -> data);
			temp = temp -> link;
		}
		printf("%d\n", temp -> data);
	}
}














