

#define PRIME_NO 7
struct hash
{
	int key;
	int flag;
};
typedef struct hash hash_t;

void initialize_Hash(hash_t*, int);
void insert_Into_Hash(hash_t*, int, int, int*);
void delete_From_Hash(hash_t*, int, int, int*);
void display(hash_t*, int);
