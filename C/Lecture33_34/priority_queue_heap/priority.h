struct heap
{
	int data;
	int priority;
};
typedef struct heap heap_t;


void insert(heap_t*, heap_t, int*);
void swap(heap_t*, heap_t*);
void heapify(heap_t*, int);
void delete_Min(heap_t*, int*);
void display(heap_t*, int);
