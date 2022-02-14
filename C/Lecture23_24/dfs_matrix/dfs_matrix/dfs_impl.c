#include<stdio.h>

int visited[20] = {0};

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

void dfs(int a[20][20], int n, int var)
{
	visited[var] = 1;
	printf("%d\n", var);
	for(int i = 1; i <= n; ++i)
	{
		if(visited[i] == 0 &&  a[var][i] == 1)
		{
			dfs(a, n, i);
		}
	}	
}

//checks if a directed graph is connected using DFS
int is_Connected(int n)
{
	/*for(int i = 1; i <= n; ++i)
	{
		printf("%d\t", visited[i]);
	}
		printf("\n");*/
	for(int i = 1; i <=n; i++)
	{
		if(visited[i] == 0)
		{
			return 0;
		}
	}
	return 1;
	printf("\n");
}










