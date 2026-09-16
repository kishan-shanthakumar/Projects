#include<stdio.h>

void construct_Graph(int (*a)[20], int);
void print_Graph(int (*a)[20], int);
void bfs(int (*a)[20], int, int);

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

	bfs(a, n_v, s_v);
	
	
}
