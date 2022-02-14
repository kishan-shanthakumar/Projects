#define SIZE 20

struct stack
{
	int s[SIZE];
	int sp;
};
typedef struct stack stack_t;


void initialize_Stack(stack_t*);
void push(stack_t*, int);
int pop(stack_t*);
int peep(stack_t*);
int isEmpty(stack_t*);
int isFull(stack_t*);



