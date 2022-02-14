
struct node
{
	int data;
	struct node* link;
};
typedef struct node node_t;

struct singly_list
{
	node_t* head;
};
typedef struct singly_list s_list;

void initialize_list(s_list*);
void insert_beginning(s_list*, int);
void insert_rear(s_list*, int);
int sum_Of_Elements(s_list* l);
void display_list(s_list*);


