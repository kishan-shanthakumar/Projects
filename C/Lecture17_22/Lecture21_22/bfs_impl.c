#include<stdio.h>
#include<stdlib.h>
#include"bfs.h"
#include"queue.h"

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

void bfs(graph_t* g, int v)
{
	Q q;
	initialize_Queue(&q);
	g -> visited[v] = 1;
	printf("%d\n", v);
	enqueue(&q, v);
	int i;
	while(!isEmpty(&q))
	{
		i = dequeue(&q);
		node_t* temp = NULL;
		for(temp = g -> list[i]; temp != NULL; temp = temp -> link)
		{
			//temp -> data;
			if(g -> visited[temp -> data] != 1)
			{
				g -> visited[temp -> data] = 1;
				printf("%d\n", temp -> data);
				enqueue(&q, temp -> data);
			}
		}
		
	}
	
	
}








