#include<stdio.h>
#include<stdlib.h>
#include"dlist.h"

void initialize_list(d_list* l)
{
	l -> head = NULL;
	l -> tail = NULL;
	l -> no_Of_Nodes = 0;
}

node_t* create_Node(int data, node_t* llink, node_t* rlink)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> data = data;
	new -> llink = llink;
	new -> rlink = rlink;
	return new;
}

void insert_beginning(d_list* l, int data)
{
	node_t* new = create_Node(data, l -> tail, l -> head);
	if(l -> head != NULL)
	{
		l -> head -> llink = new;
		l -> tail -> rlink = new;	
	}
	else
	{
		new -> llink = new -> rlink = new;
		l -> tail = new;
	}
	l -> head = new;
	++l -> no_Of_Nodes;
}

void insert_rear(d_list* l, int data)
{
	node_t* new = create_Node(data, l -> tail, l -> head);
	if(l -> tail != NULL)
	{
		l -> tail -> rlink = new;
		l -> head -> llink = new;
			
	}
	else
	{
		new -> llink = new -> rlink = new;
		l -> head = new;
	}
	l -> tail = new;
	++l -> no_Of_Nodes;
}


void delete_beginning(d_list* l)
{
	if(l -> head == NULL)
	{
		printf("Empty list, cannot delete");
		return;
		
	}
	else if(l -> head -> rlink == l -> head)
	{
		free(l -> head);
		l -> head = l -> tail = NULL;
	}
	else
	{
		l -> head = l -> head -> rlink;
		free(l -> head -> llink);	
		l -> head -> llink = l -> tail;
		l -> tail -> rlink = l -> head;
	}
	--l -> no_Of_Nodes;
}


void delete_rear(d_list* l)
{
	if(l -> head == NULL)
	{
		printf("Empty list, cannot delete");
		return;
		
	}
	else if(l -> head -> rlink == l -> head)
	{
		free(l -> head);
		l -> head = l -> tail = NULL;
	}
	else
	{
		l -> tail = l -> tail -> llink;
		free(l -> tail -> rlink);	
		l -> head -> llink = l -> tail;
		l -> tail -> rlink = l -> head;
	}
	--l -> no_Of_Nodes;
}

void display_list(d_list* l)
{
	if(l -> head == NULL)
	{
		printf("Empty list, cannot display\n");
		return;
	}
	node_t* temp = l -> head;
	while(temp -> rlink != l -> head)
	{
		printf("%d\n", temp -> data);
		temp = temp -> rlink;
	}
	printf("%d\n", temp -> data);
}

