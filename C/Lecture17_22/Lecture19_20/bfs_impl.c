#include<stdio.h>
#include"queue.h"

void construct_Graph(int a[20][20], int n)
{
	for(int i = 1; i <= n; ++i)
	{
		for(int j = 1; j <= n; ++j)
		{
			scanf("%d", &a[i][j]);
		}
	}
}

void print_Graph(int a[20][20], int n)
{
	for(int i = 1; i <= n; ++i)
	{
		for(int j = 1; j <= n; ++j)
		{
			printf("%d\t", a[i][j]);
		}
		printf("\n");
	}
}

void bfs(int a[20][20], int n, int var)
{
	Q q;
	initialize_Queue(&q);
	int visited[20] = {0};
	printf("%d\n", var);
	visited[var] = 1;
	enqueue(&q, var);
	while(!isEmpty(&q))
	{
		var = dequeue(&q);
		for(int i = 1; i <= n; ++i)
		{
			if(a[var][i] == 1 && visited[i] != 1)
			{
				visited[i] = 1;
				printf("%d\n", i);	
				enqueue(&q, i);
			}
		}
	}
	
}








