#include<stdio.h>

int visited[20] = {0};

int connected_Components(int a[20][20], int* visited, int n);
void dfs(int (*a)[20], int, int);

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
	printf("Number of connected components are %d\t", connected_Components(a, visited, n));
	printf("\n");
}


int connected_Components(int a[20][20], int* visited, int n)
{
   	/*for(int i = 1; i <= n; i++)
	{
    	visited[i] = 0;
	}*/

	int count = 0;
	for(int i = 1; i <= n; i++)
	{
		if(visited[i] == 0)
		{
			++count;
			dfs(a, n, i);	
		}
	}
	return count;
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












