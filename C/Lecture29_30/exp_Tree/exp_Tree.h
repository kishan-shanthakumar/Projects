#ifndef E
	#define E
struct node
{
	char data;
	struct node* left;
	struct node* right;
};
typedef struct node node_t;


node_t* create_Exp_Tree(char*);
void push(node_t**, node_t*, int*);
int evaluate_Exp_Tree(node_t*);
node_t* pop(node_t**, int*);
int is_Operator(char ch);
void inorder(node_t* root);
#endif
