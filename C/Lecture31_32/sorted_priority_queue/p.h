struct node
{
	int data;
	int priority;
	struct node* link;
};
typedef struct node node_t;

struct list
{
	node_t* head;
};
typedef struct list list_t;


void enqueue(list_t*, int, int);
void dequeue(list_t*);
void display(list_t*);


