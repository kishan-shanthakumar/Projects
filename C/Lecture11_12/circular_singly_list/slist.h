
struct node
{
	int data;
	struct node* link;
};
typedef struct node node_t;

struct singly_list
{
	node_t* head;
	int no_Of_Nodes;
};
typedef struct singly_list s_list;

void initialize_list(s_list*);
void insert_beginning(s_list*, int);
void insert_rear(s_list*, int);
int sum_Of_Elements(s_list* l);
void display_list(s_list*);
void delete_beginning(s_list*);
void delete_rear(s_list* l);
int count_Nodes(s_list* l);
void delete_Element(s_list*, int);
void insert_At_Position(s_list*, int, int);
int find_Largest(s_list*);
void reverse_List(s_list*);
void ordered_List(s_list*, int);
void concatenate_List(s_list*, s_list*);
void delete_List(s_list*);
