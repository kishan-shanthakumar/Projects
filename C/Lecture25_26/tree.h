#ifndef A
 #define A
struct node
{
	int data;
	struct node* left;
	struct node* right;
};
typedef struct node node_t;

struct tree
{
	node_t* root;
};
typedef struct tree tree_t;


void initialize_Tree(tree_t*);
void insert(tree_t*, int);
node_t* create_Node(int data);

#endif
