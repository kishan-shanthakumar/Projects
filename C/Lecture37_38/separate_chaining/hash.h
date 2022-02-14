#ifndef H
#define H

struct node
{
	int key;	
	char name[100];
	struct node* link;
};
typedef struct node node_t;


struct hash
{
	node_t* head;
};
typedef struct hash hash_t;



void insert(hash_t*, int, char*, int);
void initialize_Hash(hash_t*, int);s
void display(hash_t*, int);
void delete_From_Hash(hash_t*, int, int);
void search_Hash(hash_t*, int, int);

#endif
