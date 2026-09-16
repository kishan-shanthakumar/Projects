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
	node_t* new = create_Node(data, NULL, l -> head);
	if(l -> head != NULL)
	{
		l -> head -> llink = new;	
	}
	else
	{
		l -> tail = new;
	}
	l -> head = new;
	++l -> no_Of_Nodes;
}

void insert_rear(d_list* l, int data)
{
	node_t* new = create_Node(data, l -> tail, NULL);
	if(l -> tail != NULL)
	{
		l -> tail -> rlink = new;
			
	}
	else
	{
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
	else if(l -> head -> rlink == NULL)
	{
		free(l -> head);
		l -> head = l -> tail = NULL;
	}
	else
	{
		l -> head = l -> head -> rlink;
		free(l -> head -> llink);	
		l -> head -> llink = NULL;
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
	else if(l -> head -> rlink == NULL)
	{
		free(l -> head);
		l -> head = l -> tail = NULL;
	}
	else
	{
		l -> tail = l -> tail -> llink;
		free(l -> tail -> rlink);
		l -> tail -> rlink = NULL;
	}
	--l -> no_Of_Nodes;
}

void insert_At_Index(d_list* l, int index, int data)
{
	if(index < 0 || index > (l -> no_Of_Nodes - 1) || l -> no_Of_Nodes == 0)
	{
		return;	
	}
	else
	{
		node_t* curr = l -> head;
		for(int i = 0; i < index; ++i)
		{
			curr = curr -> rlink;
		}
		node_t* prev = curr -> llink;
		node_t* new = create_Node(data, prev, curr);
		if(prev != NULL)
		{
			
			prev -> rlink = new;
		}
		else
		{
			l -> head = new;
		}
		curr -> llink = new;
		++l -> no_Of_Nodes;
	}
	--l -> no_Of_Nodes;
}


void display_list(d_list* l)
{
	node_t* temp = l -> head;
	while(temp != NULL)
	{
		printf("%d\n", temp -> data);
		temp = temp -> rlink;
	}
}

