#ifndef H
#define H

struct hash
{
	int key;	
	char name[100];
	int flag;
};
typedef struct hash hash_t;


void insert(hash_t*, int, char*, int, int*);
void initialize_Hash(hash_t*, int);
void display(hash_t*, int);
void delete_From_Hash(hash_t*, int, int, int*);
void search_Hash(hash_t*, int, int);

#endif
