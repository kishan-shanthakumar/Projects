#include<stdio.h>

void construct_Graph(int (*a)[20], int);
void print_Graph(int (*a)[20], int);
void dfs(int (*a)[20], int, int);

int main()
{
	int a[20][20] = {0};
	int n_v;
	printf("Enter the number of vertices\n");
	scanf("%d", &n_v);

	construct_Graph(a, n_v);

	print_Graph(a, n_v);
	
	int s_v;
	printf("Enter the source vertex\n");
	scanf("%d", &s_v);

	dfs(a, n_v, s_v);

	if(is_Connected(n_v))
	{
		printf("Connected\n");
	}
	else
	{
		printf("Disconnected\n");
	}
}
