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
	/*if(l -> head == NULL)
	{
		l -> head = new;
	}
	else*/
	{
		new -> link = l -> head;
		l -> head = new;
		++l -> no_Of_Nodes;
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
	++l -> no_Of_Nodes;
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


void delete_beginning(s_list* l)
{
	if(l -> head == NULL)
	{
		printf("Empty list\n");
	}
	else
	{
		node_t* temp = l -> head;
		l -> head = temp -> link;
		free(temp);
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
	else if(temp -> link == NULL)
	{
		free(temp);
		l -> head = NULL;
	}
	else
	{
		
		while(temp -> link -> link != NULL)
		{
			temp = temp -> link;
			
		}
		free(temp -> link);
		temp -> link = NULL;
	}
	--l -> no_Of_Nodes;
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

int count_Nodes(s_list* l)
{
	return l -> no_Of_Nodes;
}

void delete_Element(s_list* l, int data)
{
	node_t* temp = l-> head;
	if(l -> head == NULL)
	{
		printf("Empty list\n");
		return;
	}
	else if(temp -> data == data)
	{
		l -> head = temp -> link;
		free(temp);
		temp = NULL;
	}
	else
	{
		node_t* prev = NULL;
		while(temp -> data != data && temp != NULL)
		{
			prev = temp;
			temp = temp -> link;
		}
		if(temp == NULL)
		{
			printf("Element not found in the list\n");
			return;
		}
		prev -> link = temp -> link;
		free(temp);
		
	}
	--l -> no_Of_Nodes;
}

void insert_At_Position(s_list* l, int pos, int data)
{
	if(l -> no_Of_Nodes == 0 || pos < 0 || pos > (l -> no_Of_Nodes))
	{
		printf("Invalid position\n");
		return;
	}
	node_t* new = create_Node(data);
	node_t* temp = l -> head;
	node_t* prev = NULL;		
	for(int i = 1; i < pos; ++i)
	{
		prev = temp;
		temp = temp -> link;
	}
	if(prev == NULL)
	{
		l -> head = new;
		new -> link = temp;
	}
	else
	{
		new -> link = temp;
		prev -> link = new;
	}
	++l -> no_Of_Nodes;
}

int find_Largest(s_list* l)
{
	node_t* temp = l -> head;
	int large = l -> head -> data;
	while(temp != NULL)
	{
		if(temp -> data > large)
		{
			large = temp -> data;
			
		}
		temp = temp -> link;	
	}
	return large;	
}



