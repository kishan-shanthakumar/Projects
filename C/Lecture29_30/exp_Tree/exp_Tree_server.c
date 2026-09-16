#include<stdio.h>
#include<stdlib.h>
#include"exp_Tree.h"
node_t* create_Node(char ch)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> data = ch;
	new -> left = NULL;
	new -> right = NULL;
	
	return new;
	
}

node_t* create_Exp_Tree(char* postfix)
{
	int top = -1;
	node_t* stack[100];
	int i = 0;
	char ch;
	while(postfix[i] != '\0')
	{
		ch = postfix[i];
		node_t* new = create_Node(ch);
		if(!is_Operator(ch))
		{
			push(stack, new, &top);
		}
		else
		{
			new -> right = pop(stack, &top);
			new -> left = pop(stack, &top);
			push(stack, new, &top);
		}
		++i;
	}
	return pop(stack, &top);
}


int is_Operator(char ch)
{
	if(ch == '+' || ch == '-' || ch == '*' || ch == '/')
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

void push(node_t** stack, node_t* new, int* top)
{
	(*top)++;
	stack[*top] = new;
}


void inorder(node_t* root)
{
	if(root != NULL)
	{
		inorder(root -> left);
		printf("%c ", root -> data);
		inorder(root -> right);
	}
}

node_t* pop(node_t** stack, int* top)
{
	node_t* temp = stack[*top];
	(*top)--;
	return temp;
}

int evaluate_Exp_Tree(node_t* root)
{
	switch(root -> data)
	{
		case '+' : return evaluate_Exp_Tree(root -> left) + evaluate_Exp_Tree(root -> right);
		case '-' : return evaluate_Exp_Tree(root -> left) - evaluate_Exp_Tree(root -> right);
		case '*' : return evaluate_Exp_Tree(root -> left) * evaluate_Exp_Tree(root -> right);
		case '/' : return evaluate_Exp_Tree(root -> left) / evaluate_Exp_Tree(root -> right);
		default: return(root -> data - '0');
	}
	return 0;
}


