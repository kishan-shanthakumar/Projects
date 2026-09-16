#define VAL 3
struct arraylist
{
	int a[VAL];
	int rear;
};
typedef struct arraylist array_list;

void insert(array_list*, int);
void display(array_list*);
