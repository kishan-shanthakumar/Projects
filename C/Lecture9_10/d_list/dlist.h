
struct node
{
	int data;
	struct node* llink;
	struct node* rlink;
};
typedef struct node node_t;

struct doubly_list
{
	node_t* head;
	node_t* tail;
	int no_Of_Nodes;
};
typedef struct doubly_list d_list;

void initialize_list(d_list*);
void insert_beginning(d_list*, int);
void insert_rear(d_list*, int);
int sum_Of_Elements(d_list* l);
void display_list(d_list*);
void delete_beginning(d_list*);
void delete_rear(d_list* l);
int count_Nodes(d_list* l);
void delete_Element(d_list*, int);
void insert_At_Position(d_list*, int, int);
int find_Largest(d_list*);
