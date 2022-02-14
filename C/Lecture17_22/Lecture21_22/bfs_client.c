#include<stdio.h>
#include"bfs.h"

int main()
{
	int n;
	printf("Enter the number of nodes\n");
	scanf("%d", &n);
	graph_t* g = create_Graph(n);
	int i, j;
	while(1)
	{
		printf("Enter the source and destination nodes\n");
		scanf("%d%d", &i, &j);
		if(i == -1 && j == -1)
		{
			break;
		}
		else
		{
			construct_Edge(g, i, j);
		}	
	}
	int s_v;
	printf("Enter the source vertex\n");
	scanf("%d", &s_v);
	bfs(g, s_v);
	return 0;
}

