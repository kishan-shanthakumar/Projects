#define MAX 20
struct queue
{
	int q[MAX];
	int front;
	int rear;
};
typedef struct queue Q;

void initialize_Queue(Q*);
void enqueue(Q*, int);
int dequeue(Q*);
void display(Q*);
int front(Q*);
int isFull(Q* queue);
int isEmpty(Q* queue);
