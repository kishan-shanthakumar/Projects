
#include<stdio.h>
#include<stdbool.h>
#include<stdlib.h>
#include"tree.h"

void initialize_Tree(tree_t* t)
{
	t -> root = NULL;
}

node_t* create_Node(int key)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> data = key;
	new -> left = NULL;
	new -> right = NULL;

	return new;
}

node_t* recursive_Insert(node_t* root, node_t* new)
{
	if(root == NULL)
	{
		root = new;
	}
	else if(new -> data < root -> data)
	{
		root -> left = recursive_Insert(root -> left, new);
	}
	else if(new -> data > root -> data)
	{
		root -> right = recursive_Insert(root -> right, new);
	}
	return root;
}

void insert(tree_t* t, int key)
{
	node_t* new = create_Node(key);
	t -> root = recursive_Insert(t -> root, new);
}

void recursive_Inorder(node_t* root)
{
	if(root != NULL)
	{
		recursive_Inorder(root -> left);
		printf("%d\t", root -> data);
		recursive_Inorder(root -> right);
	}
	printf("\n");
}
void inorder(tree_t* t)
{
	recursive_Inorder(t -> root);
}

void recursive_Preorder(node_t* root)
{
	if(root != NULL)
	{
		printf("%d\t", root -> data);
		recursive_Preorder(root -> left);
		recursive_Preorder(root -> right);
	}
	printf("\n");
}

void preorder(tree_t* t)
{
	recursive_Preorder(t -> root);
}

void recursive_Postorder(node_t* root)
{
	if(root != NULL)
	{	
		recursive_Postorder(root -> left);
		recursive_Postorder(root -> right);
		printf("%d\t", root -> data);
	}
	printf("\n");
}

void postorder(tree_t* t)
{
	recursive_Postorder(t -> root);
}


int rec_Min(node_t* root)
{
	if(root == NULL)
	{
		return -1;
	}
	else
	{
		node_t* temp = root;
		while(temp -> left != NULL)
		{
			temp = temp -> left;
		}
		return temp -> data;
	}
}

int min(tree_t* t)
{
	return rec_Min(t -> root);
}


bool rec_Search(node_t* root, int data)
{
	bool res;
	if(root == NULL)
	{
		return false;
	}
	if(root -> data == data)
	{
		return true;
	}
	else if(root -> data > data)
	{
		res = rec_Search(root -> left, data);
	}
	else if(root -> data < data)
	{
		res = rec_Search(root -> right, data);
	}
	return res;
}

bool search(tree_t* t, int data)
{
	return rec_Search(t -> root, data);
}



