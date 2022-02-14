#ifndef A
	#define A
struct node
{
	int data;
	struct node* link;
};
typedef struct node node_t;

struct Graph
{
	int nodes;
	int* visited;
	node_t** list;
};
typedef struct Graph graph_t;


void bfs(graph_t*, int);
node_t* create_Node(int);
void construct_Edge(graph_t*, int, int);
graph_t* create_Graph(int);

#endif
