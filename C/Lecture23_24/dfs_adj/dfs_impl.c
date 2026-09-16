#include<stdio.h>
#include<stdlib.h>
#include"dfs.h"


graph_t* create_Graph(int nodes)
{
	graph_t* g = (graph_t*)malloc(sizeof(graph_t));
	g -> nodes = nodes;
	
	g -> visited = (int*)malloc(nodes * sizeof(int));
	g -> list = (node_t**)malloc(nodes * sizeof(node_t*));

	for(int i = 0; i < nodes; ++i)
	{
		g -> visited[i] = 0;
		g -> list[i] = NULL;
	}
	return g;	
}


node_t* create_Node(int data)
{
	node_t* new = (node_t*)malloc(sizeof(node_t));
	new -> data = data;
	new -> link = NULL;

	return new;
}

void construct_Edge(graph_t* g, int i, int j)
{
	node_t* new = create_Node(j);
	
	if(g -> list[i] == NULL)
	{
		g -> list[i] = new;
	}
	else
	{
		node_t* temp = g -> list[i];
		while(temp -> link != NULL)
		{
			temp = temp -> link;
		}
		temp -> link = new;
	}
}

void dfs(graph_t* g, int v)
{
	g -> visited[v] = 1;
	printf("%d\n", v);

	node_t* temp = NULL;
	for(temp = g -> list[v]; temp != NULL; temp = temp -> link)
	{
		if(g -> visited[temp -> data] == 0)
		{
			dfs(g, temp -> data);
		}
	}
}


/*int connected_Components(int n)
{
	int count = 0;
	for(int i = 1; i <= n; i++)
	{
		if(visited[i] == 1)
		{
			++count;
			dfs(a, n, i);	
		}
	}
	return count;
}
*/






